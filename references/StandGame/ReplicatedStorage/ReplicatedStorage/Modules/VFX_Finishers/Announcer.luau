 

 

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
local l__LocalPlayer__9 = game.Players.LocalPlayer;
v1["Set Up"] = function(...) --[[ Line: 33 ]]
    -- upvalues: u2 (ref), u3 (ref), u4 (ref), u5 (ref)
    local v6 = ...;
    u2 = v6.Client_Mod;
    u3 = v6.Misc_Functions;
    u4 = v6.VFX;
    u5 = v6.VFX_2;
end;
local l__Name__10 = script.Name;
local u7 = l__Objects__6:FindFirstChild("Finishers"):FindFirstChild(l__Name__10);
l__Anims__5:FindFirstChild("Finishers"):FindFirstChild(l__Name__10);
local u8 = l__Sounds__7:FindFirstChild("Finishers"):FindFirstChild(l__Name__10);
v1["Finisher: " .. l__Name__10] = function(...) --[[ Line: 54 ]]
    -- upvalues: l__LocalPlayer__9 (copy), u7 (copy), l__FunctionLibrary__4 (copy), l__TweenService__2 (copy), l__Debris2__8 (copy), u8 (copy)
    local v9 = ...;
    local l__Origin__11 = v9.Origin;
    local _ = v9.RespawnTime;
    local l__Parent__12 = l__Origin__11.Parent;
    (l__Parent__12:FindFirstChild("Humanoid") or l__Parent__12:FindFirstChild("AnimationController")):SetStateEnabled(Enum.HumanoidStateType.Dead, false);
    if l__LocalPlayer__9.Character == l__Parent__12 or v9.User == l__LocalPlayer__9.Character then
        local u10 = u7.ScreenGui:Clone();
        u10.Parent = l__LocalPlayer__9.PlayerGui;
        l__FunctionLibrary__4.pcall(function() --[[ Line: 69 ]]
            -- upvalues: l__LocalPlayer__9 (ref), u10 (copy)
            local v11, _ = game.Players:GetUserThumbnailAsync(l__LocalPlayer__9.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420);
            u10.Frame.User.Image = v11;
        end);
        l__FunctionLibrary__4.pcall(function() --[[ Line: 78 ]]
            -- upvalues: l__Parent__12 (copy), u10 (copy)
            local l__UserId__13 = game.Players:GetPlayerFromCharacter(l__Parent__12).UserId;
            local v12, _ = game.Players:GetUserThumbnailAsync(l__UserId__13, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420);
            u10.Frame.Victim.Image = v12;
        end);
        delay(2, function() --[[ Line: 89 ]]
            -- upvalues: u10 (copy), l__TweenService__2 (ref)
            for _, v13 in pairs(u10.Frame:GetDescendants()) do
                if v13:IsA("ImageLabel") then
                    l__TweenService__2:Create(v13, TweenInfo.new(1), {
                        ImageTransparency = 1,
                        BackgroundTransparency = 1
                    }):Play();
                elseif v13:IsA("TextLabel") then
                    l__TweenService__2:Create(v13, TweenInfo.new(1), {
                        TextTransparency = 1
                    }):Play();
                elseif v13:IsA("Frame") then
                    l__TweenService__2:Create(v13, TweenInfo.new(1), {
                        BackgroundTransparency = 1
                    }):Play();
                elseif v13:IsA("UIStroke") then
                    l__TweenService__2:Create(v13, TweenInfo.new(1), {
                        Transparency = 1
                    }):Play();
                end;
            end;
        end);
        l__Debris2__8:AddItem(u10, 3);
    end;
    l__FunctionLibrary__4.PlaySound({
        Sound = u8,
        Origin = l__Origin__11,
        ClientOnly = l__LocalPlayer__9.Character == l__Parent__12 and true or v9.User == l__LocalPlayer__9.Character
    });
    local v14 = u7.Billboard:Clone();
    v14.Parent = l__Parent__12.PrimaryPart;
    l__Debris2__8:AddItem(v14, 4);
end;
return v1;