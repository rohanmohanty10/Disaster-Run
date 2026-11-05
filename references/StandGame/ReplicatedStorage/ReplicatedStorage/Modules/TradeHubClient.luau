 

 

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__VoiceChatService__2 = game:GetService("VoiceChatService");
local l__Players__3 = game:GetService("Players");
local l__Modules__4 = l__ReplicatedStorage__1:WaitForChild("Modules");
local l__Promise__5 = require(l__Modules__4.Promise);
local u1 = {
    Queue = false,
    GetTradeHubRemote = function(_) --[[ Name: GetTradeHubRemote, Line 30 ]]
        -- upvalues: l__ReplicatedStorage__1 (copy)
        return l__ReplicatedStorage__1:FindFirstChild("TradeHubRemote") or nil;
    end
};
function u1.TeleportToRandomServer(_) --[[ Line: 41 ]]
    -- upvalues: u1 (copy)
    if u1.Queue then
    else
        local v2 = u1:GetTradeHubRemote();
        if v2 then
            u1.Queue = true;
            v2:InvokeServer({
                VoiceChat = false
            });
            u1.Queue = false;
        end;
    end;
end;
function u1.TeleportToVCServer(_) --[[ Line: 52 ]]
    -- upvalues: u1 (copy), l__Players__3 (copy), l__Promise__5 (copy), l__VoiceChatService__2 (copy)
    if u1.Queue then
    else
        local u3 = u1:GetTradeHubRemote();
        if u3 then
            u1.Queue = true;
            local l__UserId__6 = l__Players__3.LocalPlayer.UserId;
            l__Promise__5.spawn(function(p4, p5) --[[ Line: 9 ]]
                -- upvalues: l__UserId__6 (copy), l__VoiceChatService__2 (ref)
                if l__UserId__6 == nil then
                    p5("Invalid UserId");
                end;
                local u6 = false;
                local v7, v8 = pcall(function() --[[ Line: 16 ]]
                    -- upvalues: u6 (ref), l__VoiceChatService__2 (ref), l__UserId__6 (ref)
                    u6 = l__VoiceChatService__2:IsVoiceEnabledForUserIdAsync(l__UserId__6);
                end);
                if v7 then
                    p4(u6);
                else
                    p5(v8);
                end;
            end):Then(function(p9) --[[ Line: 61 ]]
                -- upvalues: u3 (copy), l__Players__3 (ref), u1 (ref)
                if p9 then
                    u3:InvokeServer({
                        VoiceChat = true
                    });
                else
                    warn("Player does not have voice enabled, do some sort of warning.");
                    l__Players__3.LocalPlayer.Character.BindableEvent:Fire("Message", {
                        Duration = 5,
                        Text = "You do NOT have Voice Chat enabled!",
                        Sound = {
                            Sound = "Error",
                            ClientOnly = true
                        }
                    });
                end;
                u1.Queue = false;
            end):Catch(function(p10) --[[ Line: 75 ]]
                -- upvalues: u1 (ref)
                u1.Queue = false;
                warn(p10);
            end);
        end;
    end;
end;
function u1.PromiseOnlineFriends(_, u11) --[[ Line: 82 ]]
    -- upvalues: l__Promise__5 (copy)
    return l__Promise__5.spawn(function(p12, p13) --[[ Line: 83 ]]
        -- upvalues: u11 (copy)
        local u14 = nil;
        local v15, v16 = pcall(function() --[[ Line: 86 ]]
            -- upvalues: u14 (ref), u11 (ref)
            u14 = u11:GetFriendsOnline(200);
        end);
        if not v15 then
            p13(v16);
        end;
        p12(u14);
    end);
end;
return u1;