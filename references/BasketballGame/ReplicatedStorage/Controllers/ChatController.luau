 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TextChatService = game:GetService("TextChatService");
local Players = game:GetService("Players");
local Knit = require(ReplicatedStorage.Packages.Knit);
local u1 = Knit.CreateController({
    Name = "ChatController"
});
local ChatWindowConfiguration = TextChatService.ChatWindowConfiguration;
local u2 = newproxy();
u1.DYNAMIC = u2;
u1.ChatTags = {};

for _, descendant in ReplicatedStorage.Assets.ChatTags:GetDescendants() do
    if descendant:IsA("StringValue") then
        u1.ChatTags[descendant.Name] = {
            tag = descendant.Value,
            color = descendant:FindFirstChildOfClass("UIGradient")
        };
    end;

    if descendant:IsA("ModuleScript") then
        u1.ChatTags[descendant.Name] = u2;
    end;
end;

local u3 = {};
local u4 = nil;

function u1.OnChatWindowAdded(p5: userdata) -- Line: 35
    -- upvalues: ChatWindowConfiguration (copy), Players (copy), u1 (copy), u2 (copy), u3 (copy), u4 (ref)
    if p5.TextSource then
        local v6 = ChatWindowConfiguration:DeriveNewMessageProperties();
        local PlayerByUserId = Players:GetPlayerByUserId(p5.TextSource.UserId);
        local Attribute = PlayerByUserId:GetAttribute("Prefix");

        if Attribute and Attribute ~= "" then
            local v7 = u1.ChatTags[Attribute];

            if v7 == u2 then
                if not u3[PlayerByUserId] then
                    u3[PlayerByUserId] = {};
                end;

                if not u3[PlayerByUserId][Attribute] then
                    u3[PlayerByUserId][Attribute] = u4:ResolvePrefix(PlayerByUserId, Attribute);
                    local UIGradient = Instance.new("UIGradient");
                    UIGradient.Color = u3[PlayerByUserId][Attribute].color;
                    u3[PlayerByUserId][Attribute].color = UIGradient;
                end;

                local v8 = u3[PlayerByUserId][Attribute];
                v6.PrefixText = v6.PrefixText .. `[{v8.tag}]`;
                v6.PrefixTextProperties = ChatWindowConfiguration:DeriveNewMessageProperties();
                v8.color:Clone().Parent = v6.PrefixTextProperties;
            else
                v6.PrefixText = v6.PrefixText .. `[{v7.tag}]`;
                v6.PrefixTextProperties = ChatWindowConfiguration:DeriveNewMessageProperties();
                v7.color:Clone().Parent = v6.PrefixTextProperties;
            end;
        end;

        local Attribute2 = PlayerByUserId:GetAttribute("ForcePrefix");
        local Attribute3 = PlayerByUserId.Team:GetAttribute("Color");

        if v6.PrefixText == "" then
            v6.PrefixText = `<font color="#{Attribute3:ToHex()}">{p5.PrefixText}</font>`;

            if Attribute2 then
                v6.PrefixText = Attribute2 .. " " .. v6.PrefixText;
            end;
        else
            v6.Text = `<font color="#{Attribute3:ToHex()}">{p5.PrefixText}</font>` .. " ";

            if Attribute2 then
                v6.Text = Attribute2 .. " " .. v6.Text;
            end;
        end;

        v6.Text = v6.Text .. p5.Text;

        return v6;
    end;

    if p5.Metadata == "CustomSystemMsg" then
        local v9 = ChatWindowConfiguration:DeriveNewMessageProperties();
        local UIGradient = Instance.new("UIGradient");
        UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromHex("ff9803")), ColorSequenceKeypoint.new(1, Color3.fromHex("ffe057")) });
        v9.PrefixText = "<b>[Game]</b>";
        v9.PrefixTextProperties = ChatWindowConfiguration:DeriveNewMessageProperties();
        UIGradient.Parent = v9.PrefixTextProperties;

        return v9;
    end;
end;

function u1.OnIncomingMessage(p10: userdata) -- Line: 122
    -- upvalues: Players (copy)
    local TextSource = p10.TextSource;

    if TextSource then
        TextSource = Players:GetPlayerByUserId(TextSource.UserId);
    end;

    if not TextSource then
        return nil;
    end;

    local Attribute = TextSource:GetAttribute("ChatPrefix");
    local Attribute2 = TextSource:GetAttribute("ChatColor");
    local TextChatMessageProperties = Instance.new("TextChatMessageProperties");
    TextChatMessageProperties.PrefixText = Attribute ~= nil and `{Attribute} {p10.PrefixText}` or p10.PrefixText;
    TextChatMessageProperties.Text = Attribute2 ~= nil and `<font color='{Attribute2}'>{p10.Text}</font>` or p10.Text;

    return TextChatMessageProperties;
end;

function u1.KnitInit(p11) -- Line: 140
    -- upvalues: TextChatService (copy), u1 (copy), ReplicatedStorage (copy), Players (copy), u3 (copy)
    TextChatService.OnChatWindowAdded = u1.OnChatWindowAdded;
    ReplicatedStorage.Remotes.SystemMessage.OnClientEvent:Connect(function(p12) -- Line: 144
        -- upvalues: TextChatService (ref)
        TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage(p12, "CustomSystemMsg");
    end);
    ReplicatedStorage.Remotes.AuditLogMessage.OnClientEvent:Connect(function(p13) -- Line: 148
        -- upvalues: TextChatService (ref)
        TextChatService["PS Audit Log"]:DisplaySystemMessage(p13);
    end);
    Players.PlayerRemoving:Connect(function(p14) -- Line: 152
        -- upvalues: u3 (ref)
        if u3[p14] then
            u3[p14] = nil;
        end;
    end);
    TextChatService.ChatInputBarConfiguration:GetPropertyChangedSignal("TargetTextChannel"):Connect(function() -- Line: 158
        -- upvalues: TextChatService (ref)
        TextChatService.ChatInputBarConfiguration.Enabled = TextChatService.ChatInputBarConfiguration.TargetTextChannel.Name ~= "PS Audit Log";
    end);
end;

function u1.KnitStart(p15) -- Line: 163
    -- upvalues: u4 (ref), Knit (copy)
    u4 = Knit.GetService("ChatTagService");
end;

return u1;