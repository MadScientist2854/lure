const flecs = @import("flecs");
pub const mod_2d = @import("../2d/init.zig").components;

pub fn init(world: *flecs.World) void {
    mod_2d.init(world);
}