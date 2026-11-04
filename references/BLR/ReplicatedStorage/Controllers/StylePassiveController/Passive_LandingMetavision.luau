  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Trove = require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Controllers.StatesController);
local BallController = require(ReplicatedStorage.Controllers.BallController);
local PlayerData = require(ReplicatedStorage.ClientModules.ClientGlobals).PlayerData;

return {
    hook = function(p1, u2) -- Line: 22, Name: hook
        -- upvalues: Trove (copy), BallController (copy), RunService (copy), PlayerData (copy)
        local u3 = Trove.new();
        u3:Add(BallController:ObserveBall(function(u4) -- Line: 24
            -- upvalues: u3 (copy), u2 (copy), RunService (ref), PlayerData (ref)
            if not u4 then
                return function() -- Line: 26
                end;
            end;

            local v5 = u3:Extend();
            local u6 = false;
            local WireframeHandleAdornment = Instance.new("WireframeHandleAdornment");
            WireframeHandleAdornment.Adornee = workspace.Terrain;
            WireframeHandleAdornment.Color3 = u2 and Color3.new(0.0709392, 0.448295, 0.962051) or Color3.fromRGB(255, 255, 255);
            WireframeHandleAdornment.Thickness = u2 and 3 or 1.5;
            WireframeHandleAdornment.Parent = u4;
            v5:Add(WireframeHandleAdornment);
            local u7 = nil;
            local u8 = nil;
            local u9 = 0;
            v5:Add(RunService.Heartbeat:Connect(function(p10) -- Line: 42
                -- upvalues: u4 (copy), PlayerData (ref), u6 (ref), WireframeHandleAdornment (copy), u7 (ref), u8 (ref), u9 (ref)
                local AssemblyLinearVelocity = u4.AssemblyLinearVelocity;
                local Position = u4.Position;
                local Vector3_new_ret = Vector3.new(0, -workspace.Gravity, 0);
                local v11;

                if Position.Y > 9.5 and (AssemblyLinearVelocity.Magnitude > 5 and u4.Parent == workspace) then
                    v11 = PlayerData.Data.Settings.BallTrajectoryVision;
                else
                    v11 = false;
                end;

                if not v11 then
                    u7 = nil;
                    u6 = false;
                    u9 = 0;
                    WireframeHandleAdornment:Clear();

                    return;
                end;

                if u6 then
                    WireframeHandleAdornment:Clear();
                    WireframeHandleAdornment:AddLine(Position, Position + AssemblyLinearVelocity * 10);

                    return;
                end;

                if u7 then
                    if (Position - u7).Magnitude > u8 + 0.1 then
                        u9 = u9 + p10;

                        if u9 > 1 then
                            u6 = true;

                            return;
                        end;
                    else
                        u9 = u9 - p10;
                    end;
                end;

                u7 = Position + AssemblyLinearVelocity * p10 + Vector3_new_ret * 0.5 * p10 ^ 2;
                u8 = (Position - u7).Magnitude;
                local v12 = 0.999;
                local v13 = { Position };

                for i = 1, 180 do
                    Position = Position + AssemblyLinearVelocity * 0.016666666666666666;
                    AssemblyLinearVelocity = AssemblyLinearVelocity + Vector3_new_ret * 0.016666666666666666;

                    if Position.Y <= 18 then
                        v12 = v12 - 0.0003333333333333333;
                        AssemblyLinearVelocity = Vector3.new(AssemblyLinearVelocity.X * v12, AssemblyLinearVelocity.Y, AssemblyLinearVelocity.Z * v12);
                    end;

                    if Position.Y < 27 and Position.Y > 8 then
                        AssemblyLinearVelocity = AssemblyLinearVelocity + Vector3.new(0, 1.3666667, 0);
                    end;

                    table.insert(v13, Position);

                    if Position.Y < 8 then
                        break;
                    end;

                    local _ = i;
                end;

                WireframeHandleAdornment:Clear();
                WireframeHandleAdornment:AddPath(v13, false);
            end));

            return v5:WrapClean();
        end));

        return u3, function(p14) -- Line: 114
        end;
    end
};