  

 

return function(u1) -- Line: 1
    local Knit = u1.Knit;
    local u2 = Knit.GetService("EmoteService");
    local u3 = Knit.GetService("ShopService");
    local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
    local u4 = table.find(PathShortcuts.TestPlaces, game.PlaceId);
    local Parent = script.Parent;
    local CommunityPack1Contributors = require(script.CommunityPack1Contributors);
    u1.Emotes = { "DefaultDance", "TortureDance", "CaramellDansen", "Smug", "LoseControl", "Infestation", "FNF", "PAC-MAN", "Backflip", "spooky month", "Disco", "Door Stuck", "spinning", "Break My Stride", "The Shape" };
    local MarketplaceService = game:GetService("MarketplaceService");

    local function OwnsEmotePack(p5, p6) -- Line: 31
        -- upvalues: MarketplaceService (copy), u1 (copy), u3 (copy), u4 (copy)
        for _, v in type(p5) ~= "table" and ({ p5 } or p5) or p5 do
            if type(v) == "number" then
                if MarketplaceService:UserOwnsGamePassAsync(u1.Player.UserId, v) or (u3:OwnsGamepass(u1.Player.UserId, v):expect() or (game:GetService("RunService"):IsStudio() or u4)) then
                    for _, v2 in p6 do
                        table.insert(u1.Emotes, v2);
                    end;

                    return;
                end;
            elseif type(v) == "function" and v(u1) == true then
                for _, v2 in p6 do
                    table.insert(u1.Emotes, v2);
                end;

                return;
            end;
        end;
    end;

    OwnsEmotePack(
        13675608,
        { "SmoothMoves", "SmoothCriminal", "Kazotsky", "IevanPolkka", "God-Step", "90s", "Rodeo", "Cshearer" }
    );
    OwnsEmotePack(
        14014491,
        { "Sweet Dreams", "Peanut", "Troll", "Do The Odyssey", "Gangnam Style", "DIO\'s Talent", "Futsal Shuffle", "Nae-Nae", "Griddy", "Distraction Dance" }
    );
    OwnsEmotePack(
        822694616,
        { "Chirumiru", "California", "Chrono", "Kobeni", "Lagtrain", "Minos Shoe", "Pull Up Stuntin\'", "Zom 100", "Goopie" }
    );
    OwnsEmotePack(
        822666635,
        { "Sigma", "Cat Break Dance", "The Noobie Shuffle", "UG with the bros", "Goofy Dance", "Hakari Dance", "Livsey", "Mannrobics", "Penguin Dance", "Prince Of Egypt" }
    );
    OwnsEmotePack(
        837754540,
        { "Company Jig", "Houdini", "Geto Walk", "Astley", "TOXIC Laugh", "Take the L", "Subject Three", "Bonfire", "Slim Rap", "Judas", "Can You Remember The Rain" }
    );
    OwnsEmotePack({ 948648926, function() -- Line: 124
            -- upvalues: CommunityPack1Contributors (copy), u1 (copy)
            return table.find(CommunityPack1Contributors, u1.Player.UserId) and true or nil;
        end }, { "Syndrome Walk", "Mesmerizer", "Duck Dance", "Button Mashing", "Bye Bye Bye", "24 Hour Cinderella", "Adiantum", "Stock Dancin\'", "Specialist Dance", "Conga", "Chinese Waiter", "Andrew Dance", "Lofi Headbang", "Universal Peace Sign", "Cancun", "Copter" });
    OwnsEmotePack(
        920471052,
        { "Gojo Walk", "Yuji Walk", "Honored One", "Mahito Run", "Curse Stance", "Yuki Kiss", "Gojo Dance", "I\'ll murder you!", "Nanami Overtime", "Lost In Paradise", "Specialz", "Nah, I\'d win (1)", "Nah, I\'d win (2)", "Nah, I\'d win (3)" }
    );
    u1.EmotePage = 1;
    u1.EmoteTrove = require(Knit.Util.Trove).new();

    function u1.UpdateEmotes(p7) -- Line: 164
        -- upvalues: Parent (copy), u2 (copy)
        p7.EmoteTrove:Clean();
        local v8 = 10 * p7.EmotePage - 10;

        for i = v8, v8 + 10 do
            local v9 = i % 10;
            local v10 = Parent.List:FindFirstChild((tostring(v9 == 0 and 10 or v9)));
            local u11 = p7.Emotes[i];

            if v10 then
                if u11 then
                    v10.Button.Label.Text = u11;
                    p7.EmoteTrove:Add(v10.Button.MouseButton1Down:Connect(function() -- Line: 180
                        -- upvalues: u2 (ref), u11 (copy), Parent (ref)
                        u2:Play(u11);
                        Parent.Visible = false;
                    end));
                else
                    v10.Button.Label.Text = "";
                    p7.EmoteTrove:Add(v10.Button.MouseButton1Down:Connect(function() -- Line: 186
                        -- upvalues: Parent (ref)
                        Parent.Visible = false;
                    end));
                end;
            end;
        end;
    end;

    function u1.SetEmotePage(p12, p13) -- Line: 194
        local v14 = math.ceil(#p12.Emotes / 10);
        p12.EmotePage = math.clamp(p13, 1, v14);
        p12:UpdateEmotes();
    end;

    Parent:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 200
        -- upvalues: u1 (copy)
        u1:UpdateEmotes();
    end);
    Parent.Back.MouseButton1Down:Connect(function() -- Line: 204
        -- upvalues: u1 (copy)
        u1:SetEmotePage(u1.EmotePage - 1);
        u1:PlaySound("Click");
    end);
    Parent.Next.MouseButton1Down:Connect(function() -- Line: 209
        -- upvalues: u1 (copy)
        u1:SetEmotePage(u1.EmotePage + 1);
        u1:PlaySound("Click");
    end);
    local u15 = {
        One = 1,
        Two = 2,
        Three = 3,
        Four = 4,
        Five = 5,
        Six = 6,
        Seven = 7,
        Eight = 8,
        Nine = 9,
        Zero = 10
    };
    game:GetService("UserInputService").InputBegan:Connect(function(p16, p17) -- Line: 231
        -- upvalues: u1 (copy), u15 (copy), u2 (copy), Parent (copy)
        if u1.Locked then
            return;
        end;

        if not (p17 or u1.UI.Menus.Visible) then
            if u1.UI.Gameplay.Emotes.Visible then
                local v18 = u15[p16.KeyCode.Name] and u1.Emotes[u15[p16.KeyCode.Name] + (10 * u1.EmotePage - 10)];

                if v18 then
                    u2:Play(v18);
                    Parent.Visible = false;
                end;

                if p16.KeyCode == Enum.KeyCode.LeftBracket then
                    u1:SetEmotePage(u1.EmotePage - 1);
                    u1:PlaySound("Click");
                end;

                if p16.KeyCode == Enum.KeyCode.RightBracket then
                    u1:SetEmotePage(u1.EmotePage + 1);
                    u1:PlaySound("Click");
                end;
            end;

            if p16.KeyCode == Enum.KeyCode.Period then
                u1.UI.Gameplay.Emotes.Visible = not u1.UI.Gameplay.Emotes.Visible;
                u1:PlaySound("Click");
            end;
        end;
    end);
end;