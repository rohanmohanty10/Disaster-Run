 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
game:GetService("LocalizationService");
game:GetService("HttpService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Shared.Utility.NumberUtil);
require(ReplicatedStorage.Shared.Utility.GetUnixTime);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Shards = require(ReplicatedStorage.Packages.Shards);
local u1 = Trove.new();
local v2 = Knit.CreateController({
    Name = "Gamemodes"
});

function v2.KnitInit(p3) -- Line: 21
end;

function v2.KnitStart(p4) -- Line: 25
    -- upvalues: Knit (copy), LocalPlayer (copy), u1 (copy), Effects (copy), TweenService (copy), RunService (copy), Shards (copy)
    local Service = Knit.GetService("CustomServerService");
    Knit.GetController("UIController");
    local Controller = Knit.GetController("PartyController");
    local Controller2 = Knit.GetController("Network");
    local Gamemodes = LocalPlayer.PlayerGui:WaitForChild("Gamemodes");
    Gamemodes:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 33
        -- upvalues: u1 (ref), Gamemodes (copy), Controller2 (copy), Service (copy), Effects (ref), Controller (copy), TweenService (ref), RunService (ref)
        u1:Clean();

        if Gamemodes.Enabled then
            Gamemodes.BG.Holder.Contents.SubList.AFK.BottomNote.Note.UIGradient.Rotation = -20;

            for _, descendant in Gamemodes.BG.Holder.Contents:GetDescendants() do
                if descendant:IsA("ImageButton") then
                    local Parent = descendant.Parent;
                    u1:Connect(descendant.MouseButton1Down, function() -- Line: 43
                        -- upvalues: Parent (copy), Controller2 (ref), Service (ref), Effects (ref), Gamemodes (ref), Controller (ref)
                        if Parent.Name == "Pro" then
                            if Controller2.ServerType == "Pro" then
                                Service:JoinNormal();

                                return;
                            end;

                            if Controller2.Player.Level < 35 then
                                Effects:Popup("Your level is too low!");

                                return;
                            end;

                            Service:JoinPro();

                            return;
                        end;

                        if Parent.Name == "NoLimited" then
                            Service:JoinNoLimited();

                            return;
                        end;

                        if Parent.Name == "AFK" then
                            Service:JoinAFK();

                            return;
                        end;

                        if Parent.Name == "Ranked" then
                            Gamemodes.Enabled = false;
                            Controller:OpenUI();
                        end;
                    end);
                    local u5 = nil;
                    u1:Add(function() -- Line: 66
                        -- upvalues: u5 (ref)
                        if u5 then
                            u5:Cancel();
                            u5 = nil;
                        end;
                    end);
                    u1:Connect(Gamemodes:GetPropertyChangedSignal("Enabled"), function() -- Line: 73
                        -- upvalues: u5 (ref)
                        if u5 then
                            u5:Cancel();
                            u5 = nil;
                        end;
                    end);
                    u1:Connect(descendant.MouseEnter, function() -- Line: 80
                        -- upvalues: TweenService (ref), Parent (copy), u5 (ref)
                        TweenService:Create(Parent.Bg, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ImageColor3 = Color3.fromRGB(255, 255, 255)
                        }):Play();
                        TweenService:Create(Parent.TextFrame.UIScale, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                            Scale = 1.15
                        }):Play();
                        TweenService:Create(Parent.TextFrame, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                            Rotation = math.random(0, 1) == 0 and -3 or 3
                        }):Play();
                        u5 = true;

                        while u5 do
                            u5 = TweenService:Create(Parent.Outline.UIStroke.UIGradient, TweenInfo.new(4, Enum.EasingStyle.Linear), {
                                Rotation = Parent.Outline.UIStroke.UIGradient.Rotation + 360
                            });
                            u5:Play();
                            task.wait(4);
                        end;
                    end);
                    u1:Connect(descendant.MouseLeave, function() -- Line: 94
                        -- upvalues: u5 (ref), TweenService (ref), Parent (copy)
                        if u5 then
                            u5:Cancel();
                            u5 = nil;
                        end;

                        TweenService:Create(Parent.Bg, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ImageColor3 = Color3.fromRGB(150, 150, 150)
                        }):Play();
                        TweenService:Create(Parent.TextFrame.UIScale, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Scale = 1
                        }):Play();
                        TweenService:Create(Parent.TextFrame, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Rotation = 0
                        }):Play();
                        TweenService:Create(Parent.Outline.UIStroke.UIGradient, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Rotation = 90
                        }):Play();
                    end);
                    task.spawn(function() -- Line: 106
                        -- upvalues: Gamemodes (ref), RunService (ref), Parent (copy)
                        while Gamemodes.Enabled do
                            local v6 = -0.22;

                            while v6 <= 1.22 do
                                v6 = v6 + RunService.Heartbeat:Wait() * 1.45;
                                Parent.BgHighlight.UIGradient.Transparency = NumberSequence.new({
                                    NumberSequenceKeypoint.new(0, 1),
                                    NumberSequenceKeypoint.new(math.clamp(v6 - 0.22, 0, 1), 1),
                                    NumberSequenceKeypoint.new(math.clamp(v6 - 0.17, 0, 1), 0.65),
                                    NumberSequenceKeypoint.new(math.clamp(v6, 0, 1), 0.15),
                                    NumberSequenceKeypoint.new(math.clamp(v6 + 0.17, 0, 1), 0.65),
                                    NumberSequenceKeypoint.new(math.clamp(v6 + 0.22, 0, 1), 1),
                                    NumberSequenceKeypoint.new(1, 1)
                                });
                            end;

                            task.wait(1);
                        end;
                    end);
                end;
            end;

            while Gamemodes.Enabled do
                TweenService:Create(Gamemodes.BG.Holder.Contents.SubList.AFK.BottomNote.Note.UIGradient, TweenInfo.new(2.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Rotation = 20
                }):Play();
                task.wait(2.15);

                if not Gamemodes.Enabled then
                    break;
                end;

                TweenService:Create(Gamemodes.BG.Holder.Contents.SubList.AFK.BottomNote.Note.UIGradient, TweenInfo.new(2.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Rotation = -20
                }):Play();
                task.wait(2.15);
            end;
        end;
    end);
    local ShardForPlayer = Shards.getShardForPlayer(LocalPlayer);
    local ShardName = Shards.getShardName(ShardForPlayer);
    Gamemodes.BG.Holder.Contents.Ranked.Subtext.Text = "QUEUE REGION: " .. string.upper(ShardName == "Other" and "Unknown" or ShardName);

    if Controller2.ServerType == "Pro" then
        Gamemodes.BG.Holder.Contents.Pro.TextFrame.Title.Text = "NORMAL";
        Gamemodes.BG.Holder.Contents.Pro.Subtext.Visible = false;
    end;
end;

return v2;