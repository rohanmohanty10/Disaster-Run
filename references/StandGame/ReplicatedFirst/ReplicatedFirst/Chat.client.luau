 

 

local l__Players__1 = game:GetService("Players");
local l__TextChatService__2 = game:GetService("TextChatService");
local l__LocalPlayer__3 = l__Players__1.LocalPlayer;
local l__ChatWindowConfiguration__4 = l__TextChatService__2.ChatWindowConfiguration;
function l__TextChatService__2.OnIncomingMessage(p1) --[[ Line: 9 ]]
    -- upvalues: l__ChatWindowConfiguration__4 (copy), l__Players__1 (copy)
    local v2 = l__ChatWindowConfiguration__4:DeriveNewMessageProperties();
    local l__TextSource__5 = p1.TextSource;
    if l__TextSource__5 then
        local v3 = l__Players__1:GetPlayerByUserId(l__TextSource__5.UserId);
        if v3 == nil then
            return;
        end;
        p1.PrefixText = string.gsub(p1.PrefixText, v3.DisplayName, v3.Name);
    end;
    return v2;
end;
l__TextChatService__2.SendingMessage:Connect(function(p4) --[[ Line: 26 ]]
    -- upvalues: l__Players__1 (copy), l__LocalPlayer__3 (copy)
    print(p4);
    local l__TextSource__6 = p4.TextSource;
    if l__TextSource__6 then
        local l__UserId__7 = l__TextSource__6.UserId;
        local l__Text__8 = p4.Text;
        local v5 = l__Players__1:GetPlayerByUserId(l__UserId__7);
        if v5 == nil then
        elseif v5 == l__LocalPlayer__3 then
            print("its a local player");
            print(l__TextSource__6, l__Text__8);
        end;
    end;
end);