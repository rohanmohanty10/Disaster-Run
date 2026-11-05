 

 

local v1 = {};
game:GetService("CollectionService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("PhysicsService");
local l__TweenService__2 = game:GetService("TweenService");
game:GetService("Lighting");
local l__Modules__3 = l__ReplicatedStorage__1:WaitForChild("Modules");
local l__FunctionLibrary__4 = require(l__Modules__3:WaitForChild("FunctionLibrary"));
require(l__Modules__3:WaitForChild("ChannelMod2"));
workspace:WaitForChild("Living");
local l__Anims__5 = l__ReplicatedStorage__1:WaitForChild("Anims");
workspace:WaitForChild("IgnoreInstances");
local l__Objects__6 = l__ReplicatedStorage__1:WaitForChild("Objects");
local l__Sounds__7 = l__ReplicatedStorage__1:WaitForChild("Sounds");
local l__Debris2__8 = require(l__Modules__3:WaitForChild("Debris2"));
require(l__ReplicatedStorage__1.Modules.CameraShaker);
local u2 = nil;
local _ = workspace.CurrentCamera;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local _ = game.Players.LocalPlayer;
v1["Set Up"] = function(...) --[[ Line: 33 ]]
    -- upvalues: u2 (ref), u3 (ref), u4 (ref), u5 (ref)
    local v6 = ...;
    u2 = v6.Client_Mod;
    u3 = v6.Misc_Functions;
    u4 = v6.VFX;
    u5 = v6.VFX_2;
end;
local l__Name__9 = script.Name;
local u7 = l__Objects__6:FindFirstChild("Finishers"):FindFirstChild(l__Name__9);
l__Anims__5:FindFirstChild("Finishers"):FindFirstChild(l__Name__9);
local u8 = l__Sounds__7:FindFirstChild("Finishers"):FindFirstChild(l__Name__9);
v1["Finisher: " .. l__Name__9] = function(...) --[[ Line: 54 ]]
    -- upvalues: l__FunctionLibrary__4 (copy), u8 (copy), l__Debris2__8 (copy), u7 (copy), l__TweenService__2 (copy)
    local v9 = ...;
    local l__Origin__10 = v9.Origin;
    local _ = v9.RespawnTime;
    local l__Parent__11 = l__Origin__10.Parent;
    (l__Parent__11:FindFirstChild("Humanoid") or l__Parent__11:FindFirstChild("AnimationController")):SetStateEnabled(Enum.HumanoidStateType.Dead, false);
    l__FunctionLibrary__4.PlaySound({
        Sound = u8,
        Origin = l__Origin__10
    });
    l__Origin__10.Anchored = true;
    for v10, _ in pairs(l__FunctionLibrary__4.BodyParts.All) do
        l__Parent__11[v10].Anchored = true;
    end;
    for _, v11 in pairs(l__Parent__11:GetDescendants()) do
        if v11:IsA("BasePart") and v11.Name ~= "HumanoidRootPart" then
            v11.Material = "Slate";
            v11.BrickColor = BrickColor.new("Medium stone grey");
        end;
        if v11:IsA("SpecialMesh") then
            v11.TextureId = "";
        end;
        if v11:IsA("MeshPart") then
            v11.TextureID = "";
        end;
    end;
    local v12 = Instance.new("Attachment");
    l__Debris2__8:AddItem(v12, 4.95);
    v12.Parent = l__Origin__10;
    for _, v13 in ipairs(u7.End:GetChildren()) do
        v13:Clone().Parent = v12;
    end;
    local v14 = u7.menacing:Clone();
    l__Debris2__8:AddItem(v14, 4);
    v14.Parent = l__Origin__10;
    l__FunctionLibrary__4.EmitParticle(v12);
    l__FunctionLibrary__4.EmitParticle(l__Origin__10);
    local v15 = l__Parent__11:FindFirstChildOfClass("Shirt");
    local v16 = l__Parent__11:FindFirstChildOfClass("Pants");
    if v15 then
        v15:Destroy();
    end;
    if v16 then
        v16:Destroy();
    end;
    task.wait(3.5);
    l__Parent__11:BreakJoints();
    for _, v17 in pairs(l__Parent__11:GetDescendants()) do
        if v17:IsA("BasePart") and v17.Name ~= "HumanoidRootPart" then
            v17.Anchored = false;
            v17.CanCollide = true;
            l__TweenService__2:Create(v17, TweenInfo.new(Random.new():NextNumber(0.7, 1.7)), {
                Size = Vector3.new(0, 0, 0)
            }):Play();
        end;
    end;
end;
return v1;