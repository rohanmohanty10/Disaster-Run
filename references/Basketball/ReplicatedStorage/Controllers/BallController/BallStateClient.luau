 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Remotes = ReplicatedStorage.Remotes;
local SetBallIFrame = Remotes.BallState.SetBallIFrame;
local SetBallNoShoot = Remotes.BallState.SetBallNoShoot;
local SetBallTeamIFrame = Remotes.BallState.SetBallTeamIFrame;
local SetBallPlayerInZone = Remotes.BallState.SetBallPlayerInZone;
local SetCurrentBallPlayer = Remotes.BallState.SetCurrentBallPlayer;
local SetPreviousBallPlayer = Remotes.BallState.SetPreviousBallPlayer;
local ConnectToBallState = Remotes.BallState.ConnectToBallState;
local ReplicateBallNetworkOwner = Remotes.BallState.ReplicateBallNetworkOwner;
local LocalPlayer = Players.LocalPlayer;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = false;
local u6 = false;
local u7 = tick();
local u8 = tick();
local u9 = {};

local function connectRemoteEvent(u10, p11, u12) -- Line: 59
    return p11.OnClientEvent:Connect(function(...) -- Line: 60
        -- upvalues: u12 (copy), u10 (copy)
        u12(u10, ...);
    end);
end;

local function setBallIFrameClientEvent(p13, p14) -- Line: 66
    -- upvalues: u8 (ref)
    u8 = p14;
end;

local function setBallTeamIFrameClientEvent(p15, p16) -- Line: 69
    -- upvalues: u7 (ref)
    u7 = p16;
end;

local function updateBallNetworkOwnerClientEvent(p17, p18) -- Line: 72
    -- upvalues: u3 (ref)
    u3 = p18;
end;

local function setCurrentBallPlayerClientEvent(p19, p20, p21) -- Line: 75
    -- upvalues: u2 (ref), u4 (ref), u9 (copy)
    u2 = p20;

    if p21 or p20 ~= nil then
        u4 = p20;
    end;

    for i, _ in u9 do
        i(u2);
    end;
end;

local function setPreviousBallPlayerClientEvent(p22, p23) -- Line: 86
    -- upvalues: u1 (ref)
    u1 = p23;
end;

local function updateBallPlayerInZoneClientEvent(p24, p25) -- Line: 89
    -- upvalues: u5 (ref)
    u5 = p25;
end;

local function setBallNoShootClientEvent(p26, p27) -- Line: 92
    -- upvalues: u6 (ref)
    u6 = p27;
end;

return {
    initialize = function(u28) -- Line: 97, Name: initializeBallStateClient
        -- upvalues: SetBallIFrame (copy), setBallIFrameClientEvent (copy), SetBallNoShoot (copy), setBallNoShootClientEvent (copy), SetBallTeamIFrame (copy), setBallTeamIFrameClientEvent (copy), SetCurrentBallPlayer (copy), setCurrentBallPlayerClientEvent (copy), SetBallPlayerInZone (copy), updateBallPlayerInZoneClientEvent (copy), SetPreviousBallPlayer (copy), setPreviousBallPlayerClientEvent (copy), ReplicateBallNetworkOwner (copy), updateBallNetworkOwnerClientEvent (copy), ConnectToBallState (copy)
        local u29 = setBallIFrameClientEvent;
        SetBallIFrame.OnClientEvent:Connect(function(...) -- Line: 60
            -- upvalues: u29 (copy), u28 (copy)
            u29(u28, ...);
        end);
        local u30 = setBallNoShootClientEvent;
        SetBallNoShoot.OnClientEvent:Connect(function(...) -- Line: 60
            -- upvalues: u30 (copy), u28 (copy)
            u30(u28, ...);
        end);
        local u31 = setBallTeamIFrameClientEvent;
        SetBallTeamIFrame.OnClientEvent:Connect(function(...) -- Line: 60
            -- upvalues: u31 (copy), u28 (copy)
            u31(u28, ...);
        end);
        local u32 = setCurrentBallPlayerClientEvent;
        SetCurrentBallPlayer.OnClientEvent:Connect(function(...) -- Line: 60
            -- upvalues: u32 (copy), u28 (copy)
            u32(u28, ...);
        end);
        local u33 = updateBallPlayerInZoneClientEvent;
        SetBallPlayerInZone.OnClientEvent:Connect(function(...) -- Line: 60
            -- upvalues: u33 (copy), u28 (copy)
            u33(u28, ...);
        end);
        local u34 = setPreviousBallPlayerClientEvent;
        SetPreviousBallPlayer.OnClientEvent:Connect(function(...) -- Line: 60
            -- upvalues: u34 (copy), u28 (copy)
            u34(u28, ...);
        end);
        local u35 = updateBallNetworkOwnerClientEvent;
        ReplicateBallNetworkOwner.OnClientEvent:Connect(function(...) -- Line: 60
            -- upvalues: u35 (copy), u28 (copy)
            u35(u28, ...);
        end);
        ConnectToBallState:FireServer();
    end,

    cantShootBallUntilOutOfThreePointLine = function(p36) -- Line: 133, Name: cantShootBallUntilOutOfThreePointLine
        -- upvalues: u6 (ref)
        return u6;
    end,

    ballPlayerZoneIsActive = function(p37) -- Line: 130, Name: ballPlayerZoneIsActive
        -- upvalues: u5 (ref)
        return u5;
    end,

    ballTeamIFrameIsActive = function(p38) -- Line: 127, Name: ballTeamIFrameIsActive
        -- upvalues: u7 (ref)
        return tick() < u7;
    end,

    ballIFrameIsActive = function(p39) -- Line: 124, Name: ballIFrameIsActive
        -- upvalues: u8 (ref)
        return tick() < u8;
    end,

    onPlayerPossessingBallChangedConnect = function(p40, u41, p42) -- Line: 163, Name: onPlayerPossessingBallChangedConnect
        -- upvalues: u9 (copy), u2 (ref)
        local v43 = p42 == nil and true or p42;

        if typeof(u41) ~= "function" then
            error((`{u41} is not a function!`));
        end;

        if typeof(v43) ~= "boolean" then
            error((`{v43} is not a boolean!`));
        end;

        u9[u41] = true;

        if v43 then
            u41(u2);
        end;

        return function() -- Line: 179
            -- upvalues: u9 (ref), u41 (copy)
            u9[u41] = nil;
        end;
    end,

    localPlayerIsBallNetworkOwner = function(p44) -- Line: 137, Name: localPlayerIsBallNetworkOwner
        -- upvalues: LocalPlayer (copy), u3 (ref)
        return LocalPlayer == u3;
    end,

    localPlayerPossessesBall = function(p45) -- Line: 110, Name: localPlayerPossessesBall
        -- upvalues: LocalPlayer (copy), u2 (ref)
        return LocalPlayer == u2;
    end,

    characterPossessesBall = function(p46, p47) -- Line: 116, Name: characterPossessesBall
        -- upvalues: u2 (ref)
        if u2 == nil then
            return false;
        end;

        return u2.Character == p47;
    end,

    playerPossessesBall = function(p48, p49) -- Line: 113, Name: playerPossessesBall
        -- upvalues: u2 (ref)
        return p49 == u2;
    end,

    getLastCharacterToPossessBall = function(p50) -- Line: 143, Name: getLastCharacterToPossessBall
        -- upvalues: u4 (ref)
        if u4 then
            return u4.Character;
        end;
    end,

    getCharacterPossessingBall = function(p51) -- Line: 148, Name: getCharacterPossessingBall
        -- upvalues: u2 (ref)
        if u2 then
            return u2.Character;
        end;
    end,

    getLastPlayerToPossessBall = function(p52) -- Line: 153, Name: getLastPlayerToPossessBall
        -- upvalues: u4 (ref)
        return u4;
    end,

    getPlayerPossessingBall = function(p53) -- Line: 156, Name: getPlayerPossessingBall
        -- upvalues: u2 (ref)
        return u2;
    end,

    getPreviousBallPlayer = function(p54) -- Line: 159, Name: getPreviousBallPlayer
        -- upvalues: u1 (ref)
        return u1;
    end,

    getBallNetworkOwner = function(p55) -- Line: 140, Name: getBallNetworkOwner
        -- upvalues: u3 (ref)
        return u3;
    end
};