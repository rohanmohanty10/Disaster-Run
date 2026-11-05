  

 

local TextChatService = game:GetService("TextChatService");

return function(p1) -- Line: 3
    -- upvalues: TextChatService (copy)
    TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage((`<font color="#FF0000">{p1.Message}</font>`));
end;