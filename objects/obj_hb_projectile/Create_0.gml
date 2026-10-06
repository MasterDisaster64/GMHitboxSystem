hbox = new Hitbox(
    global.enemy_hbox_target,
    new HitboxCompositeShape([
        new HitboxCircle(0, 0, 8),
        new HitboxRect(-8, 0, 16, 16),
    ])
)