 

 

local ContentProvider = game:GetService("ContentProvider");

return {
    Preload = function(p1, p2, p3) -- Line: 5, Name: Preload
        -- upvalues: ContentProvider (copy)
        local u4 = {};

        for _, descendant in ipairs(p2:GetDescendants()) do
            if descendant:IsA("Animation") then
                table.insert(u4, descendant);
            end;
        end;

        if #u4 > 0 then
            local success, result = pcall(function() -- Line: 15
                -- upvalues: ContentProvider (ref), u4 (copy)
                ContentProvider:PreloadAsync(u4);
            end);

            if not success then
                warn("Failed to preload animations:", result);
            end;
        end;

        if p3 then
            p3();
        end;
    end
};