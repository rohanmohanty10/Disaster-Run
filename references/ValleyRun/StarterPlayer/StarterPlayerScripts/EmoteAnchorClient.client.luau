 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local EmoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("Emotes"):WaitForChild("EmoteEvent");

local function moveVector() -- Line: 10
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChildOfClass("Humanoid");
    end;

    return Character and Character.MoveDirection or Vector3.new(0, 0, 0);
end;

local u1 = nil;
local u2 = nil;
local u3 = nil;

local function stopWatching() -- Line: 17
    -- upvalues: u1 (ref), u2 (ref)
    if u1 then
        u1:Disconnect();
        u1 = nil;
    end;

    if u2 then
        u2:Disconnect();
        u2 = nil;
    end;
end;

local function sendStop() -- Line: 27
    -- upvalues: u1 (ref), u2 (ref), EmoteEvent (copy)
    if u1 then
        u1:Disconnect();
        u1 = nil;
    end;

    if u2 then
        u2:Disconnect();
        u2 = nil;
    end;

    EmoteEvent:FireServer("Stop");
end;

local function follow(u4) -- Line: 31
    -- upvalues: u1 (ref), u2 (ref), u3 (ref), LocalPlayer (copy), RunService (copy), EmoteEvent (copy), UserInputService (copy), sendStop (copy)
    if u1 then
        u1:Disconnect();
        u1 = nil;
    end;

    if u2 then
        u2:Disconnect();
        u2 = nil;
    end;

    if u3 then
        u3:Disconnect();
    end;

    local function refresh() -- Line: 36
        -- upvalues: u4 (copy), u1 (ref), u2 (ref), LocalPlayer (ref), RunService (ref), EmoteEvent (ref), UserInputService (ref), sendStop (ref)
        if u4:GetAttribute("EmoteAnchored") ~= true then
            if u1 then
                u1:Disconnect();
                u1 = nil;
            end;

            if u2 then
                u2:Disconnect();
                u2 = nil;
            end;

            return;
        end;

        if u1 then
            return;
        end;

        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChildOfClass("Humanoid");
        end;

        local u5 = (Character and Character.MoveDirection or Vector3.new(0, 0, 0)).Magnitude < 0.1;
        u1 = RunService.Heartbeat:Connect(function() -- Line: 46
            -- upvalues: LocalPlayer (ref), u5 (ref), u1 (ref), u2 (ref), EmoteEvent (ref)
            local Character2 = LocalPlayer.Character;

            if Character2 then
                Character2 = Character2:FindFirstChildOfClass("Humanoid");
            end;

            local v6 = (Character2 and Character2.MoveDirection or Vector3.new(0, 0, 0)).Magnitude >= 0.1;

            if u5 then
                if v6 then
                    if u1 then
                        u1:Disconnect();
                        u1 = nil;
                    end;

                    if u2 then
                        u2:Disconnect();
                        u2 = nil;
                    end;

                    EmoteEvent:FireServer("Stop");
                end;

                return;
            end;

            u5 = not v6;
        end);
        u2 = UserInputService.JumpRequest:Connect(sendStop);
    end;

    u3 = u4:GetAttributeChangedSignal("EmoteAnchored"):Connect(refresh);
    refresh();
end;

LocalPlayer.CharacterAdded:Connect(follow);

if LocalPlayer.Character then
    follow(LocalPlayer.Character);
end;