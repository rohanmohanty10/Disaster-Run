  

 

local TextChatService = game:GetService("TextChatService");

return function(p1) -- Line: 2
    -- upvalues: TextChatService (copy)
    TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage(p1);
end;