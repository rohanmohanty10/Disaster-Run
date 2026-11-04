 
 

local script_Parent = script.Parent;
local Config = require(script_Parent:WaitForChild("Config"));
local Utilities = require(script_Parent:WaitForChild("Utilities"));
local u23 = {
    GetCFrames = function(p1, p2) -- Line: 8, Name: GetCFrames
        debug.profilebegin("Frustum::GetCFrames");
        local CFrame2 = p1.CFrame;
        local Position = CFrame2.Position;
        local RightVector = CFrame2.RightVector;
        local UpVector = CFrame2.UpVector;
        local v3 = p2 * 0.5;
        local v4 = math.tan((p1.FieldOfView + 5) * 0.5 * 0.017453) * p2;
        local v5 = v4 * (p1.ViewportSize.X / p1.ViewportSize.Y);
        local v6 = CFrame2 * CFrame.new(0, 0, -p2);
        local v7 = v6 * Vector3.new(v5, v4, 0);
        local v8 = v6 * Vector3.new(-v5, -v4, 0);
        local v9 = v6 * Vector3.new(v5, -v4, 0);
        local v10 = (CFrame2 * CFrame.new(0, 0, -v3)):Inverse();
        local Unit = UpVector:Cross(v9 - Position).Unit;
        local Unit2 = UpVector:Cross(v8 - Position).Unit;
        local Unit3 = RightVector:Cross(Position - v7).Unit;
        local Unit4 = RightVector:Cross(Position - v9).Unit;
        debug.profileend();

        return v10, v5, v4, v3, Unit, Unit2, Unit3, Unit4, CFrame2;
    end,

    InViewFrustum = function(p11, p12, p13, p14, p15, p16, p17, p18, p19, p20) -- Line: 32, Name: InViewFrustum
        debug.profilebegin("Frustum::InViewFrustum");
        local Position = p20.Position;
        local v21 = p12 * p11;

        if p13 < v21.X or (v21.X < -p13 or (p14 < v21.Y or (v21.Y < -p14 or (p15 < v21.Z or v21.Z < -p15)))) then
            debug.profileend();

            return false;
        end;

        local v22 = p11 - Position;

        if p16:Dot(v22) < 0 or (p17:Dot(v22) > 0 or (p18:Dot(v22) < 0 or p19:Dot(v22) > 0)) then
            debug.profileend();

            return false;
        end;

        debug.profileend();

        return true;
    end
};

function u23.ObjectInFrustum(p24, p25, p26, p27, p28, p29, p30, p31, p32, p33) -- Line: 73
    -- upvalues: Config (copy), Utilities (copy), u23 (copy)
    local CFrame2 = p24.CFrame;
    local Size = p24.Size;
    local v34 = Config.FAR_PLANE * 0.5;
    local v35 = Utilities.ClosestPointOnLine(p33.Position + p33.LookVector * v34, p33.LookVector, v34, CFrame2.Position);
    local v36, v37 = Utilities.ClosestPointInBox(CFrame2, Size, v35);

    return v36 and true or (u23.InViewFrustum(v37, p25, p26, p27, p28, p29, p30, p31, p32, p33) and true or false);
end;

return u23;