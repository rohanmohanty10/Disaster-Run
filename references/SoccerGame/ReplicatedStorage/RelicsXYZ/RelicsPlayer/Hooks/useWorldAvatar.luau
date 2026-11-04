  

local Parent = script.Parent.Parent;
local Shared = Parent.Parent.Shared;
local Util = require(Parent.Util);
local React = require(Shared.React);
local Promise = require(Shared.Promise);
local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local useSignal = require(Parent.Hooks.useSignal);
local u1 = nil;
local u2 = nil;

local function promiseCharacter(u3: number) -- Line: 19
    -- upvalues: Promise (copy), Players (copy)
    return Promise.new(function(p4) -- Line: 20
        -- upvalues: Players (ref), u3 (copy)
        local v5 = Players:CreateHumanoidModelFromDescription(Players:GetHumanoidDescriptionFromUserId(u3), Enum.HumanoidRigType.R15);
        local Animate = v5:FindFirstChild("Animate");

        if Animate then
            Animate:Destroy();
        end;

        v5:PivotTo(CFrame.identity);
        v5.Name = "Player";
        p4(v5);
    end);
end;

local function getCharacterModel() -- Line: 36
    -- upvalues: Util (copy), LocalPlayer (copy), u1 (ref), u2 (ref), Promise (copy), Players (copy)
    local UserId = Util.GetUserId();
    local v6 = LocalPlayer and LocalPlayer.Character;

    if v6 == u1 then
        if not u2 then
            u2 = Promise.new(function(p7) -- Line: 20
                -- upvalues: Players (ref), UserId (copy)
                local v8 = Players:CreateHumanoidModelFromDescription(Players:GetHumanoidDescriptionFromUserId(UserId), Enum.HumanoidRigType.R15);
                local Animate = v8:FindFirstChild("Animate");

                if Animate then
                    Animate:Destroy();
                end;

                v8:PivotTo(CFrame.identity);
                v8.Name = "Player";
                p7(v8);
            end);
        end;

        return u2;
    end;

    u1 = v6;
    u2 = Promise.new(function(p9) -- Line: 20
        -- upvalues: Players (ref), UserId (copy)
        local v10 = Players:CreateHumanoidModelFromDescription(Players:GetHumanoidDescriptionFromUserId(UserId), Enum.HumanoidRigType.R15);
        local Animate = v10:FindFirstChild("Animate");

        if Animate then
            Animate:Destroy();
        end;

        v10:PivotTo(CFrame.identity);
        v10.Name = "Player";
        p9(v10);
    end);

    return u2;
end;

return function(u11: number?) -- Line: 54, Name: useWorldAvatar
    -- upvalues: React (copy), Promise (copy), getCharacterModel (copy), useSignal (copy), LocalPlayer (copy)
    local u12, u13 = React.useState(nil);
    local u14, u15 = React.useState(function() -- Line: 57
        return Instance.new("WorldModel");
    end);
    React.useEffect(function() -- Line: 61
        -- upvalues: Promise (ref), getCharacterModel (ref), u13 (copy)
        Promise.retry(getCharacterModel, 5):andThen(function(p16) -- Line: 64
            -- upvalues: u13 (ref)
            u13(p16);
        end);
    end, {});
    useSignal(LocalPlayer and LocalPlayer.CharacterAdded, function() -- Line: 69
        -- upvalues: Promise (ref), getCharacterModel (ref), u13 (copy)
        Promise.retry(getCharacterModel, 5):andThen(function(p17) -- Line: 72
            -- upvalues: u13 (ref)
            u13(p17);
        end);
    end, { LocalPlayer });
    React.useEffect(function() -- Line: 77
        -- upvalues: u12 (ref), u11 (copy), u14 (copy), u15 (copy)
        local u18;

        if u12 then
            u18 = task.delay(u11 or 0, function() -- Line: 81
                -- upvalues: u12 (ref), u14 (ref), u15 (ref)
                local WorldModel = Instance.new("WorldModel");
                u12 = u12:Clone();
                u12.Parent = WorldModel;
                WorldModel.PrimaryPart = u12.PrimaryPart;
                u14:Destroy();
                u15(WorldModel);
            end);
        else
            u18 = nil;
        end;

        return function() -- Line: 93
            -- upvalues: u18 (ref)
            if u18 then
                task.cancel(u18);
            end;
        end;
    end, { u12 });

    return u14;
end;