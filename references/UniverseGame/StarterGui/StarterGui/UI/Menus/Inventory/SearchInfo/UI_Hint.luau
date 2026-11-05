  

 

return function(u1) -- Line: 23
    script.Parent.MouseButton1Click:Connect(function() -- Line: 24
        -- upvalues: u1 (copy)
        u1.NewPrompt({
            Title = "Search Bar Tip",
            Text = "To make finding things easier, you may write special search operators:\n\t\t\t\t\nWriting <b><font color=\"#dfa0ff\">@AbilityName</font></b> at the beginning of your search narrows down results to skins of <b><font color=\"##dfa0ff\">AbilityName</font></b>.\n\t\t\t\n<i>Example:</i> @standless <i>(shows all skins of Standless)</i>\n\t\t\t\nYou may still write desired names after <b><font color=\"##dfa0ff\">@AbilityName</font></b> to find skins that have the given name.\n\t\t\t\t\nAdding <b><font color=\"#ffa16a\">!</font></b> at the end of your search narrows down results to <b><font color=\"##dfa0ff\">unusual</font></b> skins.\n\t\t\t\n<i>Example:</i> ! (shows all <b><font color=\"##dfa0ff\">unusual</font></b> skins)\n\nSearching <b><font color=\"#ffa16a\">\"! PatternNumber\"</font></b> will show all the skins of that pattern.\n\nUsing <b><font color=\"#ffa16a\">& \"TraitName\"</font></b> narrows your search to <b><font color=\"##dfa0ff\">abilities</font></b> that have that specific Traits.\n\nYou can just use <b><font color=\"#ffa16a\">&</font></b> to show abilities that have traits.\n\t\t\t\t\nIt is possible to combine these operators for very specific searches.",
            Options = { "Understood" },

            Callback = function(p2) -- Line: 31, Name: Callback
                if p2.Choice == 1 then
                end;
            end
        });
    end);
end;