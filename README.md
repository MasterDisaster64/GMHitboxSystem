# GMHitboxSystem

A small hitbox system for GameMaker Studio 2. This isn't a complete combat system, but it can help you make hits register where and when you want them to, and _not_ where and when you _don't_.

A hitbox is defined by three components:

- **Shape**: _Where_ it hits.
- **Target**: _What_ it hits.
- **Tracker**: _When_ it hits. Or more precisely, when it can hit something _again_.

## Basic Use

Create a hitbox through its constructor. This can be done once in an instance's Create event.

```gml
attack_hitbox = new Hitbox(
	new HitboxRect(24, 0, 48, 12), // the shape
	obj_enemy // the target
    // uses default tracker; see below
);
```

While the attack is active, trigger the hitbox from Step.

```gml
attack_hitbox.trigger()
```

This performs a collision check and stores the newly hit targets in the hitbox's `hit_targets` array. Then you can loop through the targets and do what you want with them:

```gml
var i = 0
repeat (attack_hitbox.hit_count()) {
    var enemy = attack_hitbox.hit_targets[i++]
    enemy.take_damage(10)
}
```

Or, more succinctly, you can define a callback function in Create or in a script:

```gml
on_attack_hit = function(_enemy) {
	_enemy.take_damage(10)
};
```

Then pass it into the hitbox's `foreach` helper method after triggering:

```gml
attack_hitbox.trigger()
attack_hitbox.foreach(on_attack_hit)
```

You can even chain these together:

```gml
attack_hitbox.trigger().foreach(on_attack_hit)
```

### Other hitbox methods

- **`hit_count()`**: Returns the number of targets hit last trigger.
- **`hit_anything()`**: Returns whether any targets were hit last trigger.
- **`any(function)`**: Returns whether any of the hit targets evaluate true for the specified function.
- **`draw()`**: Draws the hitbox's shape for debugging purposes (or a training mode).

## Shapes

The system comes with a few predefined shapes:

- **`HitboxRect(x, y, width, height, [relative_to])`**:
  An axis-aligned rectangle centered at the given position. Coordinates are relative to `relative_to` by default, or absolute when `relative_to` is `noone`. Defaults to being relative to `other`.
- **`HitboxCircle(x, y, radius, [relative_to])`**: A circle with the same coordinate behavior as `HitboxRect`.
- **`HitboxObjectShape([instance])`**: Follows the collision mask of an object instance, including position, rotation and scale. Useful for defining complex hit areas through sprites and animation, or just adding contact damage. Defaults to `other`.
- **`HitboxCompositeShape([shape, ...])`**: Combines several shapes into one hit area.

It should be fairly easy to add more shapes by extending the base `HitboxShape` constructor and using GameMaker's collision functions.

## Targets

The target assigned to a hitbox can be an object type, an instance, a tile map element, or an array of these. Basically anything that can be checked for by [GameMaker's collision functions](https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Movement_And_Collisions/Collisions/Collisions.htm). It's also possible to not specify any target, and to override a hitbox's default target in the `trigger` call.

## Trackers

A tracker decides whether a target touched by the shape is included in `hit_targets`.

- **`SingleHitTracker`**: Each target can be hit once in a continuous activation. It can be hit again after the hitbox stops being triggered for at least one frame and is activated again. Suitable for a one-shot melee move or piercing projectile.
- **`RepeatHitTracker`**: Hits a target again if it leaves the hitbox and re-enters during the same activation. Suitable for a sweeping attack that should hit the same target on separate passes.
- **`ContinuousHitTracker`**: Hits every touching target once per frame. Suitable for damage-over-time areas.
- **No tracker**: specified as `pointer_null`. This will also have the effect of hitting each touching target every frame, but it may hit them multiple times if the shape's logic allows it it (e.g. a `CompositeShape` touching a target with multiple of its subshapes). In cases where this doesn't happen or isn't a problem (e.g. a projectile with a simple shape that's destroyed on hit), using no tracker saves on overhead.

If not specified, a hitbox creates its own `SingleHitTracker`. Hitboxes can also share a tracker to coordinate hits between them. For example, for a melee attack that's stronger on one end than the other, share a tracker between the tip and base hitboxes so one target is not hit by both at once:

```gml
var thrust_tracker = new SingleHitTracker();
base_hitbox = new Hitbox(new HitboxRect(48, 0, 64, 8), obj_enemy, thrust_tracker);
tip_hitbox = new Hitbox(new HitboxRect(88, 0, 16, 16), obj_enemy, thrust_tracker);
```

Trigger the hitboxes in order from highest to lowest priority. Whichever is triggered first claims any overlapping targets.

## Target filter: `hb_can_hit`

Targeted objects may optionally define a method named `hb_can_hit`. The hitbox calls it before consulting the tracker; return `true` to allow the hit or `false` to reject it. This is useful for things like team checks (the hitbox passes `other` into the method) or invulnerability frames.

```gml
hb_can_hit = function() {
	return iframes <= 0;
};
```

If the target has no `hb_can_hit` method, it's allowed by this filter. The current implementation uses `try/catch` so the method doesn't need to be defined on every target. Exceptions raised inside a defined method are caught as well, and the target continues through hit tracking, so make sure this method is reliable.

Alternatively, checks like these could be done on targets after they're registered as hit. This means single and repeat trackers won't register them if they become vulnerable while still in the hitbox, which you may or may not want depending on your game design.
