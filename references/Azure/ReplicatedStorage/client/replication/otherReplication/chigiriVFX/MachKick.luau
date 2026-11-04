 

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local mainreplication = require(script.Parent.Parent.Parent.mainreplication);
require(script.Parent.Parent.Parent.TekrinnDialogue);
local MeshEmitter = require(script.Parent.Parent.Parent.MeshEmitter);
require(ReplicatedStorage.util.raycast);
require(ReplicatedStorage.util.animationUtil);
require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
local Util = require(ReplicatedStorage.util.Util);
require(ReplicatedStorage.util.SignalValue);
local _ = Players.LocalPlayer;

return function(p1: table) -- Line: 26
    -- upvalues: ReplicatedStorage (copy), Util (copy), Debris (copy), Players (copy), mainreplication (copy), Lighting (copy), TweenService (copy), MeshEmitter (copy), RunService (copy)
    local Value = p1.Character.Value;
    local Value2 = p1.Left.Value;
    local u2 = Value.HumanoidRootPart or Value.PrimaryPart;
    local chigiri = ReplicatedStorage.Resources.chigiri;
    p1.Variant.Changed:Connect(function(p3) -- Line: 33
        -- upvalues: chigiri (copy), Util (ref), Value (copy), Debris (ref), u2 (copy), Players (ref), mainreplication (ref)
        print("Mach Kick:", p3);

        if p3 == 1 then
            if not (shared.allvfxcheck and shared.allvfxcheck()) then
                local v4 = chigiri.MachKickTorsoPart:Clone();
                Util.Weld(v4, v4, Value.Torso);
                v4.Parent = Value;
                Debris:AddItem(v4, 3);
                Util.EnableAll(v4, false, 0.1);
                task.delay(0.25, function() -- Line: 43
                    -- upvalues: chigiri (ref), Util (ref), Value (ref), Debris (ref)
                    local v5 = chigiri.chigimachcutinkick:Clone();
                    Util.Weld(v5, v5, Value.Torso, CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(3, 0, 3));
                    v5.Parent = Value;
                    Debris:AddItem(v5, 5);
                    Util.EmitAll(v5);
                end);
            end;
        elseif p3 == 2 and not (shared.allvfxcheck and shared.allvfxcheck()) then
            local v6 = chigiri.chigimachcutinkick2:Clone();
            Util.Weld(v6, v6, u2, CFrame.Angles(3.141592653589793, 0, 0) * CFrame.new(0, 1, 2));
            v6.Parent = Value;
            Debris:AddItem(v6, 5);
            Util.EmitAll(v6);
            local v7 = chigiri.chigimachcutinkick3:Clone();
            Util.Weld(v7, v7, u2, CFrame.Angles(3.141592653589793, 0, 0) * CFrame.new(0, 1, 2));
            v7.Parent = Value;
            Debris:AddItem(v7, 5);
            Util.EmitAll(v7);

            if Players.LocalPlayer == Players:GetPlayerFromCharacter(Value) then
                mainreplication.springcamerashake(25, 45);
                mainreplication.fov(false, 40);
                mainreplication.fov(true, 70, 2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            end;
        end;
    end);
    task.delay(0, function() -- Line: 74
        -- upvalues: Players (ref), Value (copy), mainreplication (ref), ReplicatedStorage (ref), Lighting (ref), TweenService (ref), Value2 (copy), MeshEmitter (ref), u2 (copy), chigiri (copy), Debris (ref), Util (ref), RunService (ref)
        if Players.LocalPlayer == Players:GetPlayerFromCharacter(Value) then
            mainreplication.springcamerashake(25, 40);
            mainreplication.fov(false, 40);
            mainreplication.fov(true, 70, 2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            local v8 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v8.Parent = Lighting;
            v8.TintColor = Color3.fromRGB(255, 111, 142);
            v8.Brightness = 0.4;
            v8.Contrast = 1;
            v8.Saturation = -0.4;
            TweenService:Create(v8, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v8, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v8.Destroy, v8);
        end;

        if not (shared.allvfxcheck and shared.allvfxcheck()) then
            if Value2 then
                MeshEmitter.StartMeshEmitter(u2, ReplicatedStorage.Resources.chigiri["machcutinrightVFX MeshEmitter"]);
            else
                MeshEmitter.StartMeshEmitter(u2, ReplicatedStorage.Resources.chigiri["machcutinleftVFX MeshEmitter"]);
            end;
        end;

        local u9 = Value:GetAttribute("MachingIt") == true;
        local u10 = Value:GetAttributeChangedSignal("MachingIt"):Connect(function() -- Line: 107
            -- upvalues: u9 (ref)
            u9 = true;
        end);
        task.spawn(function() -- Line: 111
            -- upvalues: chigiri (ref), u2 (ref), Value2 (ref), Value (ref), Debris (ref), Util (ref), u9 (ref)
            local v11 = chigiri.grassemit:Clone();
            v11.Weld.Part1 = u2;
            v11.Weld.C0 = CFrame.new(0, 2, 0) * CFrame.Angles(0, math.rad(Value2 and -90 or 90), 0);
            v11.Parent = Value;
            Debris:AddItem(v11, 10);
            Util.EmitAll(v11);

            if Value:FindFirstChild("Ball") then
                local v12 = chigiri.Ball.lightning:Clone();
                v12.Parent = Value.Ball;
                Debris:AddItem(v12, 10);
                Util.EmitAll(v12);
            end;

            local u13 = chigiri.MachCutEmitTorso.machcutin:Clone();
            u13.Parent = Value.Torso;
            Debris:AddItem(u13, 10);
            Util.EmitAll(u13);
            Util.EnableAll(u13, true);
            task.delay(0.1, function() -- Line: 132
                -- upvalues: Value2 (ref), chigiri (ref), u2 (ref), Value (ref), Debris (ref)
                local v14 = chigiri.MachBeamPart:Clone();
                v14.Weld.Part1 = u2;
                v14.Weld.C0 = v14.Weld.C0 * CFrame.Angles(0, math.rad(Value2 and 180 or 0), 0);
                v14.Parent = Value;
                Debris:AddItem(v14, 100);
                local TweenService2 = game:GetService("TweenService");

                for _, descendant in pairs(v14:GetDescendants()) do
                    if descendant:IsA("Beam") then
                        descendant.Enabled = true;
                        descendant.Brightness = 2.3;
                        TweenService2:Create(descendant, TweenInfo.new(0.47), {
                            Brightness = 0
                        }):Play();
                    end;

                    if descendant:GetAttribute("EmitDuration") then
                        task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 150
                            -- upvalues: descendant (copy)
                            descendant.Enabled = false;
                        end);
                    end;
                end;
            end);
            task.delay(0.12, function() -- Line: 157
                -- upvalues: chigiri (ref), u2 (ref), Debris (ref), Util (ref), u13 (copy)
                local v15 = chigiri.grassdrag:Clone();
                v15.Parent = u2;
                v15.Weld.Part1 = u2;
                Debris:AddItem(v15, 10);
                Util.EnableAll(u13, false, 0.1);
            end);
            task.delay(0.45, function() -- Line: 165
                -- upvalues: u9 (ref), chigiri (ref), u2 (ref), Value (ref), Debris (ref), Util (ref)
                if not u9 then
                    local v16 = chigiri.grassemitdash:Clone();
                    v16.Weld.Part1 = u2;
                    v16.Weld.C0 = CFrame.new(0, 2, 0) * CFrame.Angles(0, 2.9670597283903604, 0);
                    v16.Parent = Value;
                    Debris:AddItem(v16, 10);
                    Util.EmitAll(v16);
                end;
            end);
            task.delay(0.47, function() -- Line: 178
                -- upvalues: u9 (ref), chigiri (ref), u2 (ref), Value (ref), Debris (ref), Util (ref)
                if not u9 then
                    local v17 = chigiri.DashEmit:Clone();
                    v17.Weld.Part1 = u2;
                    v17.Parent = Value;
                    Debris:AddItem(v17, 10);
                    Util.EmitAll(v17);
                end;
            end);
            task.delay(0.49, function() -- Line: 188
                -- upvalues: u9 (ref), chigiri (ref), u2 (ref), Value (ref), Debris (ref), Util (ref)
                if not u9 then
                    local v18 = chigiri.chigirimachcutin2:Clone();
                    v18.Weld.Part1 = u2;
                    v18.Weld.C0 = CFrame.new(0, 0, -3);
                    v18.Parent = Value;
                    Debris:AddItem(v18, 10);
                    Util.EmitAll(v18);
                end;
            end);
            task.delay(0.5, function() -- Line: 199
                -- upvalues: u9 (ref), chigiri (ref), u2 (ref), Value (ref), Debris (ref), Util (ref)
                if not u9 then
                    local v19 = chigiri.runbeamchigiri:Clone();
                    v19.Weld.Part1 = u2;
                    v19.Weld.C0 = CFrame.new(0, 0, -3);
                    v19.Parent = Value;
                    Debris:AddItem(v19, 10);
                    Util.EnableAll(v19, false, 0.3);
                end;
            end);
        end);

        if Value2 then
            local u20, u21 = mainreplication.bodyVelocity(u2, 110, 1, nil, nil, true, TweenInfo.new(0.7200000000000001, Enum.EasingStyle.Linear, Enum.EasingDirection.Out));
            local u22 = nil;
            u22 = RunService.RenderStepped:Connect(function(p23) -- Line: 216
                -- upvalues: u20 (copy), u22 (ref), u2 (ref), u21 (copy)
                if u20 and u20:IsDescendantOf(game) then
                    u20.Velocity = u2.CFrame.RightVector * u21.Value;

                    return;
                end;

                u22:Disconnect();
            end);
        else
            local u24, u25 = mainreplication.bodyVelocity(u2, 110, 1, nil, nil, true, TweenInfo.new(0.7200000000000001, Enum.EasingStyle.Linear, Enum.EasingDirection.Out));
            local u26 = nil;
            u26 = RunService.RenderStepped:Connect(function(p27) -- Line: 227
                -- upvalues: u24 (copy), u26 (ref), u2 (ref), u25 (copy)
                if u24 and u24:IsDescendantOf(game) then
                    u24.Velocity = u2.CFrame.RightVector * -u25.Value;

                    return;
                end;

                u26:Disconnect();
            end);
        end;

        task.delay(0.5, function() -- Line: 235
            -- upvalues: u10 (copy), u9 (ref), Players (ref), Value (ref), mainreplication (ref), ReplicatedStorage (ref), Lighting (ref), TweenService (ref), u2 (ref)
            u10:Disconnect();

            if not u9 then
                if Players.LocalPlayer == Players:GetPlayerFromCharacter(Value) then
                    mainreplication.springcamerashake(20, 40);
                    mainreplication.fov(false, 90);
                    mainreplication.fov(true, 70, 1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
                    local v28 = ReplicatedStorage.Resources.ColorCorrection:Clone();
                    v28.Parent = Lighting;
                    v28.TintColor = Color3.fromRGB(255, 111, 142);
                    v28.Brightness = 0.4;
                    v28.Contrast = 1;
                    v28.Saturation = -0.4;
                    TweenService:Create(v28, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Saturation = 0
                    }):Play();
                    TweenService:Create(v28, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Contrast = 0,
                        Brightness = 0,
                        TintColor = Color3.fromRGB(255, 255, 255)
                    }):Play();
                    task.delay(2, v28.Destroy, v28);
                end;

                mainreplication.bodyVelocity(u2, 125, 0.5, nil, nil, nil, TweenInfo.new(0.9, Enum.EasingStyle.Linear, Enum.EasingDirection.Out));
            end;
        end);
    end);
end;