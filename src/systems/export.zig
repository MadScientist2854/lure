const flecs = @import("flecs");
pub const mod_2d = @import("../2d/init.zig").systems;

pub usingnamespace @import("rl_frame.zig");
pub usingnamespace @import("draw_fps.zig");

pub fn init(world: *flecs.World) void {
    _ = world.newSystem("Setup Rendering", .pre_store, "", setup_render);

    _ = world.newSystem("Draw FPS", .on_store, "", draw_fps);

    _ = world.newSystem("End Frame", .post_frame, "", end_frame);

    mod_2d.init(world);
}