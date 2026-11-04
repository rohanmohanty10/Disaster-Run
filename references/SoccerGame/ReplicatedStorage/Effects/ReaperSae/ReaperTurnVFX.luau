  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(u1) -- Line: 14
    -- upvalues: SpectatorController (copy), SoundManager (copy), RunService (copy), TweenService (copy), EmitModule (copy), UserInputService (copy), Debris (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        table.clear(u1);

        return;
    end;

    task.spawn(function() -- Line: 22
        -- upvalues: SoundManager (ref), u1 (ref), RunService (ref), TweenService (ref), EmitModule (ref)
        SoundManager.SpawnSound("ReaperTurn", 1.5, u1.Char.HumanoidRootPart, 150, nil);
        local u2 = script.ReaperTurn:Clone();
        u2:PivotTo(u1.Char.PrimaryPart.CFrame);
        u2.Parent = workspace.Debris;
        local u3 = RunService.Heartbeat:Connect(function() -- Line: 29
            -- upvalues: u1 (ref), u2 (copy)
            if not u1 then
                return;
            end;

            u2:PivotTo(u1.Char.PrimaryPart.CFrame);
        end);
        local u4 = script.MeshWork1:Clone();
        u4:PivotTo(u1.Char.PrimaryPart.CFrame * CFrame.Angles(1.5707963267948966, 3.141592653589793, 0));
        u4.Parent = workspace.Debris;
        local u5 = script.Highlight:Clone();
        u5.Parent = u1.Char;
        u5.FillTransparency = 1;
        TweenService:Create(u5, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true), {
            FillTransparency = 0.85
        });
        u5.OutlineTransparency = 1;
        TweenService:Create(u5, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true), {
            OutlineTransparency = 0
        });
        EmitModule.emit(u4);
        EmitModule.emit(u2);
        task.delay(2, function() -- Line: 51
            -- upvalues: u3 (copy), u2 (copy), u5 (copy), u4 (copy)
            u3:Disconnect();
            u2:Destroy();
            u5:Destroy();
            u4:Destroy();
        end);
    end);
    local u6 = UserInputService.TouchEnabled and 0.15 or 0.08;
    local u7 = {
        Color3.new(0.945098, 0.333333, 1),
        Color3.new(0.203922, 0.309804, 1),
        Color3.new(0.223529, 0.701961, 1),
        Color3.new(0.419608, 1, 0.258824),
        Color3.new(1, 0.894118, 0.298039),
        Color3.new(1, 0.227451, 0.227451),
        Color3.new(0.631373, 0.447059, 1)
    };
    local u8 = 1;
    local u9 = nil;
    local u10 = tick();
    u9 = RunService.Heartbeat:Connect(function() -- Line: 78
        -- upvalues: u1 (ref), u9 (ref), u10 (ref), u6 (ref), u8 (ref), u7 (copy), TweenService (ref), Debris (ref)
        if u1.Char == nil then
            table.clear(u1);
            u1 = nil;

            if u9 then
                u9:Disconnect();
                u9 = nil;
            end;
        end;

        if u10 + u6 < tick() then
            u10 = tick();
            u8 = u8 + 1;

            if u8 > #u7 then
                u8 = 1;
            end;

            u1.Char.Archivable = true;
            local u11 = u1.Char:Clone();
            task.delay(0.55, function() -- Line: 98
                -- upvalues: u11 (copy)
                u11:Destroy();
            end);
            task.spawn(function() -- Line: 102
                -- upvalues: u11 (copy)
                u11.Torso:FindFirstChild("Jersey"):Destroy();
            end);
            local Children = u11:GetChildren();

            for _, v in pairs(Children) do
                if v:IsA("Accessory") and v.Name == "Cape" then
                    v:Destroy();
                elseif v:IsA("Accessory") and v.Name == "Peppermint Cape" then
                    v:Destroy();
                elseif v:IsA("Accessory") and v.Name == "Santa Hat" then
                    v:Destroy();
                elseif v:IsA("Script") or v:IsA("LocalScript") then
                    v:Destroy();
                elseif v:IsA("Highlight") then
                    v.FillColor = u7[u8];
                    v.OutlineColor = u7[u8];
                    v.OutlineTransparency = 0;
                    v.FillTransparency = 0;
                    local v12 = TweenService:Create(v, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        FillTransparency = 1,
                        OutlineTransparency = 1
                    });
                    v12:Play();
                    Debris:AddItem(v12, 0.55);
                elseif v:IsA("MeshPart") or v:IsA("BasePart") then
                    v.CanCollide = false;
                    v.Anchored = true;

                    if v.Name ~= "HumanoidRootPart" then
                        local v13 = TweenService:Create(v, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            Transparency = 1
                        });
                        v13:Play();
                        Debris:AddItem(v13, 0.55);
                    end;
                elseif v:IsA("Accessory") then
                    v.Handle.CanCollide = false;
                    v.Handle.Anchored = true;
                    local v14 = TweenService:Create(v.Handle, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        Transparency = 1
                    });
                    v14:Play();
                    Debris:AddItem(v14, 0.55);
                end;
            end;

            table.clear(Children);
            u11.Parent = workspace;
        end;
    end);
    task.delay(0.4, function() -- Line: 163
        -- upvalues: u1 (ref), u9 (ref), u7 (copy), u8 (ref)
        table.clear(u1);
        u1 = nil;

        if u9 then
            u9:Disconnect();
            u9 = nil;
        end;

        table.clear(u7);
        u8 = nil;
    end);
end;