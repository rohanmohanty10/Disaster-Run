 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ContextActionService = game:GetService("ContextActionService");
local UserInputService = game:GetService("UserInputService");
local SoundService = game:GetService("SoundService");

return {
    start = function(u1) -- Line: 17, Name: start
        -- upvalues: UserInputService (copy), ContextActionService (copy), Players (copy), SoundService (copy), RunService (copy)
        local Emotes = u1.package:WaitForChild("Emotes");
        local EmotePlayback = require(Emotes:WaitForChild("EmotePlayback"));
        local EmoteCatalog = require(Emotes:WaitForChild("EmoteCatalog"));
        local EmoteEvent = Emotes:WaitForChild("EmoteEvent", 30);
        local Shared = u1.Shared;
        local player = u1.player;
        local state = u1.state;
        local u2 = nil;
        local u3 = {};
        local u4 = nil;
        local u5 = nil;
        local u6 = (-1 / 0);

        local function party() -- Line: 32
            -- upvalues: state (copy), Shared (copy)
            local Attribute = state:GetAttribute("EmoteId");
            local Attribute2 = state:GetAttribute("EmoteAt");

            if type(Attribute) == "string" and (type(Attribute2) == "number" and Shared.dance(Attribute)) then
                return Attribute, Attribute2, state:GetAttribute("EmoteForced") == true;
            end;

            return nil;
        end;

        local function start(p7, p8, p9) -- Line: 40
            -- upvalues: EmotePlayback (copy), Shared (copy)
            local v10 = EmotePlayback.load(p7, p8);

            if not v10 then
                return nil;
            end;

            v10:Play(0.2);

            if v10.Length > 0 then
                v10.TimePosition = Shared.loopTime(p9, v10.Length);
            end;

            return v10;
        end;

        local function keep(p11, p12) -- Line: 53
            -- upvalues: Shared (copy)
            if not p11 then
                return;
            end;

            if not p11.IsPlaying then
                p11:Play(0.1);
            end;

            local Length = p11.Length;

            if Length > 0 then
                local v13 = Shared.loopTime(p12, Length);
                local math_abs_ret = math.abs(p11.TimePosition - v13);

                if math_abs_ret > 0.12 and math_abs_ret < Length - 0.12 then
                    p11.TimePosition = v13;
                end;
            end;
        end;

        local function stopOwn() -- Line: 70
            -- upvalues: u2 (ref), EmotePlayback (copy)
            if u2 then
                EmotePlayback.dispose(u2.track);
                u2 = nil;
            end;
        end;

        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Name = "TrollDance";
        ScreenGui.ResetOnSpawn = false;
        ScreenGui.DisplayOrder = 70;
        ScreenGui.Enabled = false;
        ScreenGui:SetAttribute("SelfManagedText", true);
        ScreenGui.Parent = player:WaitForChild("PlayerGui");
        local TextButton = Instance.new("TextButton");
        TextButton.Name = "JumpOut";
        TextButton.AnchorPoint = Vector2.new(1, 1);
        TextButton.Position = UDim2.new(1, -24, 1, -150);
        TextButton.Size = UDim2.fromOffset(120, 54);
        TextButton.BackgroundColor3 = Color3.fromRGB(23, 23, 25);
        TextButton.BackgroundTransparency = 0.1;
        TextButton.FontFace = u1.font();
        TextButton.TextSize = 20;
        TextButton.TextColor3 = Color3.new(1, 1, 1);
        TextButton.Text = "JUMP OUT";
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(0, 12);
        UICorner.Parent = TextButton;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Thickness = 2;
        UIStroke.Color = Color3.fromRGB(255, 255, 255);
        UIStroke.Transparency = 0.6;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        UIStroke.Parent = TextButton;
        TextButton.Parent = ScreenGui;
        local u14 = nil;

        local function breakOut() -- Line: 109
            -- upvalues: party (copy), u2 (ref), u5 (ref), EmotePlayback (copy)
            local v15, v16, v17 = party();

            if v15 and (not v17 and u2) then
                u5 = v16;

                if u2 then
                    EmotePlayback.dispose(u2.track);
                    u2 = nil;
                end;
            end;
        end;

        TextButton.Activated:Connect(breakOut);
        UserInputService.JumpRequest:Connect(breakOut);
        local u18 = false;

        local function bind(p19) -- Line: 120
            -- upvalues: u18 (ref), ContextActionService (ref), party (copy), u2 (ref), u5 (ref), EmotePlayback (copy)
            if p19 == u18 then
                return;
            end;

            u18 = p19;

            if p19 then
                ContextActionService:BindActionAtPriority("CoHTrollDanceJump", function(p20, p21) -- Line: 126
                    -- upvalues: party (ref), u2 (ref), u5 (ref), EmotePlayback (ref)
                    if p21 == Enum.UserInputState.Begin then
                        local v22, v23, v24 = party();

                        if v22 and (not v24 and u2) then
                            u5 = v23;

                            if u2 then
                                EmotePlayback.dispose(u2.track);
                                u2 = nil;
                            end;
                        end;
                    end;

                    return Enum.ContextActionResult.Pass;
                end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Space, Enum.KeyCode.ButtonA);

                return;
            end;

            ContextActionService:UnbindAction("CoHTrollDanceJump");
        end;

        local function updateOwn(p25, p26, p27) -- Line: 137
            -- upvalues: player (copy), u1 (copy), u5 (ref), u2 (ref), u6 (ref), EmoteEvent (copy), EmotePlayback (copy), Shared (copy), keep (copy), ScreenGui (copy), UserInputService (ref), u14 (ref), bind (copy)
            local Character = player.Character;
            local v28;

            if Character then
                v28 = Character:FindFirstChildOfClass("Humanoid");
            else
                v28 = Character;
            end;

            local v29;

            if v28 then
                v29 = v28:FindFirstChildOfClass("Animator");
            else
                v29 = v28;
            end;

            local v30;

            if p25 == nil then
                v30 = false;
            else
                v30 = not u1.exempt();

                if v30 then
                    if u5 == p26 or v29 == nil then
                        v30 = false;
                    else
                        v30 = v28.Health > 0;
                    end;
                end;
            end;

            if v30 and (u2 and u2.humanoid == v28) then
                local Attribute = Character:GetAttribute("EmoteStartedAt");

                if Character:GetAttribute("EmoteId") ~= nil and (type(Attribute) == "number" and u2.since < Attribute) then
                    if p27 then
                        if os.clock() - u6 > 0.7 and EmoteEvent then
                            u6 = os.clock();
                            EmoteEvent:FireServer("Stop");
                        end;
                    else
                        u5 = p26;

                        if u2 then
                            EmotePlayback.dispose(u2.track);
                            u2 = nil;
                            v30 = false;
                        else
                            v30 = false;
                        end;
                    end;
                end;
            end;

            if v30 then
                if u2 and (u2.humanoid == v28 and (u2.id == p25 and u2.at == p26)) then
                    keep(u2.track, p26);
                else
                    if u2 then
                        EmotePlayback.dispose(u2.track);
                        u2 = nil;
                    end;

                    if Character:GetAttribute("EmoteId") ~= nil and (EmoteEvent and os.clock() - u6 > 0.7) then
                        u6 = os.clock();
                        EmoteEvent:FireServer("Stop");
                    end;

                    local v31 = {};
                    local v32 = EmotePlayback.load(v29, p25);

                    if v32 then
                        v32:Play(0.2);

                        if v32.Length > 0 then
                            v32.TimePosition = Shared.loopTime(p26, v32.Length);
                        end;
                    else
                        v32 = nil;
                    end;

                    v31.track = v32;
                    v31.humanoid = v28;
                    v31.id = p25;
                    v31.at = p26;
                    v31.since = workspace:GetServerTimeNow();
                    u2 = v31;
                end;
            elseif u2 then
                EmotePlayback.dispose(u2.track);
                u2 = nil;
            end;

            local v33;

            if u2 == nil then
                v33 = false;
            else
                v33 = not p27;
            end;

            local v34;

            if v33 then
                v34 = UserInputService.TouchEnabled;
            else
                v34 = v33;
            end;

            ScreenGui.Enabled = v34;

            if v33 and u14 ~= p26 then
                u14 = p26;
                u1.toast(UserInputService.TouchEnabled and "Tap JUMP OUT to stop dancing." or "Jump to stop dancing.");
            end;

            bind(v33);
        end;

        local function updateBots(p35, p36) -- Line: 183
            -- upvalues: Shared (copy), Players (ref), u3 (copy), EmotePlayback (copy), keep (copy)
            local ClientBots = workspace:FindFirstChild("ClientBots");
            local v37 = {};

            if p35 and ClientBots then
                for _, child in ClientBots:GetChildren() do
                    if child:IsA("Model") and not Shared.ownerClone(child, Players) then
                        local v38 = child:FindFirstChildOfClass("Humanoid");

                        if v38 then
                            v38 = v38:FindFirstChildOfClass("Animator");
                        end;

                        if v38 then
                            v37[child] = true;
                            local v39 = u3[child];

                            if v39 and (v39.id == p35 and (v39.at == p36 and v39.animator == v38)) then
                                keep(v39.track, p36);
                            else
                                if v39 then
                                    EmotePlayback.dispose(v39.track);
                                end;

                                local v40 = {};
                                local v41 = EmotePlayback.load(v38, p35);

                                if v41 then
                                    v41:Play(0.2);

                                    if v41.Length > 0 then
                                        v41.TimePosition = Shared.loopTime(p36, v41.Length);
                                    end;
                                else
                                    v41 = nil;
                                end;

                                v40.track = v41;
                                v40.id = p35;
                                v40.at = p36;
                                v40.animator = v38;
                                u3[child] = v40;
                            end;
                        end;
                    end;
                end;
            end;

            for i, v in u3 do
                if not v37[i] then
                    EmotePlayback.dispose(v.track);
                    u3[i] = nil;
                end;
            end;
        end;

        local function updateMusic(p42, p43) -- Line: 215
            -- upvalues: EmoteCatalog (copy), u4 (ref), SoundService (ref), Shared (copy)
            local v44;

            if p42 then
                v44 = EmoteCatalog.soundId(p42);
            else
                v44 = p42;
            end;

            if not v44 then
                if u4 then
                    u4.sound:Destroy();
                    u4 = nil;
                end;

                return;
            end;

            if not (u4 and (u4.id == p42 and u4.at == p43)) then
                if u4 then
                    u4.sound:Destroy();
                end;

                local Sound = Instance.new("Sound");
                Sound.Name = "TrollPartyMusic";
                Sound.SoundId = v44;
                Sound.Looped = true;
                local v45 = EmoteCatalog.get(p42);
                Sound.Volume = v45 and type(v45.Volume) == "number" and (v45.Volume or 0.25) or 0.25;
                Sound.Parent = SoundService;
                Sound:Play();
                u4 = {
                    sound = Sound,
                    id = p42,
                    at = p43
                };
            end;

            local TimeLength = u4.sound.TimeLength;

            if TimeLength > 0 then
                local v46 = Shared.loopTime(p43, TimeLength);

                if math.abs(u4.sound.TimePosition - v46) > 0.25 then
                    u4.sound.TimePosition = v46;
                end;
            end;
        end;

        local u47 = 0;
        RunService.Heartbeat:Connect(function(p48) -- Line: 248
            -- upvalues: u47 (ref), party (copy), updateOwn (copy), updateBots (copy), updateMusic (copy)
            u47 = u47 + p48;

            if u47 < 0.2 then
                return;
            end;

            u47 = 0;
            local v49, v50, v51 = party();
            local success, result = pcall(updateOwn, v49, v50, v51);

            if not success then
                warn("Emote party:", result);
            end;

            local success2, result2 = pcall(updateBots, v49, v50);

            if not success2 then
                warn("Emote party bots:", result2);
            end;

            pcall(updateMusic, v49, v50);
        end);
    end
};