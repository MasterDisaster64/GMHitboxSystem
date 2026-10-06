hbox = new Hitbox(
    new HitboxCompositeShape([
        new HitboxCircle(0, 0, 8),
        new HitboxRect(-8, 0, 16, 16),
    ]),
    global.enemy_hbox_target
)