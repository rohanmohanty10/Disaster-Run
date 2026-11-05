  

 

local RunService = game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local u1 = nil;
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u2 = {};
Knit:OnStart():andThen(function() -- Line: 16
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("MountService");
end);
local u4 = {
    __index = {
        Destroy = function(p3) -- Line: 21, Name: Destroy
            p3.Trove:Destroy();
        end
    }
};
local u8 = { function(p5, p6, p7) -- Line: 29
        p5.Goal.X = p6;
        p5.Goal.Y = p7;
    end };

local function u23(u9, p10, ...) -- Line: 37
    -- upvalues: u2 (copy), Fusion (copy), Trove (copy), LocalPlayer (copy), RunService (copy), u23 (ref), u1 (ref), u4 (copy), u8 (copy)
    local u11 = u2[u9];

    if p10 == nil then
        if u11 then
            u11:Destroy();
            u2[u9] = nil;
        end;

        return;
    end;

    if not u11 then
        local v12;

        if u9 then
            v12 = u9:FindFirstChild("HumanoidRootPart");
        else
            v12 = nil;
        end;

        if not v12 then
            return;
        end;

        local v13 = u9:WaitForChild("Khronos Walker", 2.5);

        if not v13 then
            return;
        end;

        local Swivel = v13:WaitForChild("Mech", 1):FindFirstChild("Main"):WaitForChild("Upper Torso", 2):FindFirstChild("Swivel");

        if u2[u9] then
            return;
        end;

        if v13 then
            local v14 = Fusion.Value(0);
            u11 = {
                StepConnection = nil,
                Character = u9,
                Mount = v13,
                Trove = Trove.new(),
                SwivelAngle = v14,
                SwivelSpring = Fusion.Spring(v14, 4.5, 0.52),
                Current = {
                    X = 0,
                    Y = 0
                },
                Goal = {
                    X = 0,
                    Y = 0
                }
            };
            local u15 = LocalPlayer.Character == u9;
            local u16 = 0;
            u11.Trove:Add(RunService.PreSimulation:Connect(function(p17) -- Line: 77
                -- upvalues: u9 (copy), u11 (ref), u2 (ref), Swivel (copy), u15 (copy), u23 (ref), u16 (ref), u1 (ref)
                if not (u9:IsDescendantOf(workspace) and u9:FindFirstChild("HumanoidRootPart")) then
                    u11:Destroy();
                    u2[u9] = nil;
                end;

                u11.SwivelAngle:set(u11.Goal.X);

                if Swivel then
                    local v18 = u11.SwivelSpring:get();
                    local v19 = Swivel;
                    v19.Transform = v19.Transform * CFrame.fromEulerAngles(0, math.rad(v18), 0, Enum.RotationOrder.XYZ);
                    local RootJoint = u9.HumanoidRootPart.RootJoint;
                    RootJoint.Transform = RootJoint.Transform * CFrame.fromEulerAngles(0, -math.rad(v18) / 10, math.rad(v18), Enum.RotationOrder.XYZ);
                end;

                if u15 then
                    local X = u9.HumanoidRootPart.CFrame:ToObjectSpace(workspace.CurrentCamera.CFrame).LookVector.X;
                    local v20 = -math.asin(X);
                    local v21 = math.deg(v20);
                    u23(u9, 0, v21, 0);

                    if u16 < os.clock() then
                        u16 = os.clock() + 0.05;
                        u1.MountUnreliableInstruction:Fire(0, v21, 0);
                    end;
                end;
            end));
            u11.Trove:Add(u11.Character:GetAttributeChangedSignal("Mount"):Connect(function() -- Line: 115
                -- upvalues: u11 (ref), u2 (ref), u9 (copy)
                if u11.Character:GetAttribute("Mount") ~= "Khronos Walker" then
                    u11:Destroy();
                    u2[u9] = nil;
                end;
            end));
            setmetatable(u11, u4);
            u2[u9] = u11;
        end;
    end;

    local v22 = u11 and u8[p10];

    if v22 then
        v22(u11, ...);
    end;
end;

return u23;