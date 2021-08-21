const flecs = @import("flecs");
const rl = @import("raylib");
const rm = @import("raymath");
const components = @import("../components/export.zig");

pub fn shoot_bullet(it: *flecs.ecs_iter_t) callconv(.C) void {
    const shooters = it.column(components.Shooter, 1);
    const positions = it.column(components.mod_2d.Position2D, 2);

    var i: usize = 0;
    while (i < it.count) : ( i += 1 ) {
        const shooter = shooters[i];
        const shooter_pos_vec = rm.Vector2 { .x = positions[i].x, .y = positions[i].y };
        var world = flecs.World { .world = it.world.? };
        const bullet_pos = world.getMut(shooter.bullet, components.mod_2d.Position2D).?;
        const bullet_pos_vec = rm.Vector2 { .x = bullet_pos.x, .y = bullet_pos.y };
        const bullet_vel = world.getMut(shooter.bullet, components.mod_2d.Velocity2D).?;
        const target_pos = world.get(shooter.target, components.mod_2d.Position2D).?;

        // teleport bullet to shooter if it's far enough
        if (bullet_pos_vec.Distance(shooter_pos_vec) > 1600) {
            bullet_pos.x = shooter_pos_vec.x;
            bullet_pos.y = shooter_pos_vec.y+25;
            // set velocity to shoot at target
            var target_dir = rm.Vector2.Zero();
            target_dir.x = -(bullet_pos.x - target_pos.x);
            target_dir.y = -(bullet_pos.y - target_pos.y);
            target_dir = target_dir.Normalize().Scale(20);
            bullet_vel.x = target_dir.x;
            bullet_vel.y = target_dir.y;
        }
    }
}