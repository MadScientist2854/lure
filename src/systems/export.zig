const flecs = @import("flecs");
pub const mod_2d = @import("../2d/init.zig").systems;

pub usingnamespace @import("rl_frame.zig");
pub usingnamespace @import("draw_fps.zig");
pub usingnamespace @import("move_player.zig");
pub usingnamespace @import("move_enemy.zig");

pub fn init(world: *flecs.World) void {
    _ = world.newSystem("Move Player", .on_update, "Player, Position2D", move_player);
    _ = world.newSystem("Move Enemy", .on_update, "Enemy, Position2D", move_enemy);

    _ = world.newSystem("Setup Rendering", .pre_store, "", setup_render);

    _ = world.newSystem("Draw FPS", .on_store, "", draw_fps);

    _ = world.newSystem("End Frame", .post_frame, "", end_frame);

    mod_2d.init(world);
}