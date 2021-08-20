pub const Vector2 = extern struct {
    x: f32,
    y: f32,

    pub fn Normalize(v: Vector2) Vector2 {
        const length = v.Length();
        if (length <= 0)
            return v;

        const result = v.Scale(1/length);
        return result;
    }

    pub fn Scale(v: Vector2, scale: f32) Vector2 {
        return Vector2 { .x = v.x*scale, .y = v.y*scale };
    }

    pub fn Subtract(v1: Vector2, v2: Vector2) Vector2 {
        return Vector2 { .x = v1.x - v2.x, .y = v1.y - v2.y };
    }

    pub fn Length(v: Vector2) f32 {
        return @sqrt((v.x*v.x) + (v.y*v.y));
    }
};