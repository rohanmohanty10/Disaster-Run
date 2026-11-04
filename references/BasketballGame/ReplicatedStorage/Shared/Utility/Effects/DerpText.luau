 
 

require(script.RichTextTypes);
local u1 = {};
u1.__index = u1;
local TextService = game:GetService("TextService");
local RunService = game:GetService("RunService");
game:GetService("StarterGui");
local ImageFrame = script.Assets.ImageFrame;
local CharacterFrame = script.Assets.CharacterFrame;
local LineFrameTemplate = script.Assets.LineFrameTemplate;
local UIListLayout = script.Assets.UIListLayout;
local WordFrameTemplate = script.Assets.WordFrameTemplate;
local u2 = {};

for _, child in script.Animations:GetChildren() do
    u2[child.Name:lower()] = require(child);
end;

local u3 = {
    FallbackAnimationStyle = "appear",
    FallbackAnimationRepeats = false,
    FallbackAnimationLength = 1,
    FallbackAnimationStep = "letter",
    LineSpacing = 0,
    WordSpacing = 8,
    LetterSpacing = 0,
    TextStrokeTransparency = 1,
    Transparency = 0,
    DefaultTimeBetweenStep = 0.05,
    DefaultTextSize = 30,
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    VerticalAlignment = Enum.VerticalAlignment.Center,
    TextStrokeColor = Color3.new(0, 0, 0),
    TextColor = Color3.new(1, 1, 1),
    DefaultFont = Font.fromName("Montserrat", Enum.FontWeight.SemiBold)
};

local function getUIScale(p4: userdata) -- Line: 198
    local v5 = p4:FindFirstAncestorWhichIsA("ScreenGui");

    if v5 == nil then
        return {
            Scale = 1
        };
    end;

    local v6 = v5:FindFirstChildWhichIsA("Frame");

    if v6 == nil then
        return {
            Scale = 1
        };
    end;

    local UIScale = v6:FindFirstChild("UIScale");

    return UIScale == nil and {
        Scale = 1
    } or UIScale;
end;

local function getWordFromRichChar(p7: table) -- Line: 212
    local v8 = "";

    for _, v in p7 do
        v8 = v8 .. v.character;
    end;

    return v8;
end;

local function parseRichText(p9: string) -- Line: 220
    local _ = #p9;
    local v10 = 1;
    local v11 = {};
    local v12 = {};
    local v13 = {};

    for i, v in utf8.graphemes(p9) do
        if v >= v10 then
            local v14 = p9:sub(i, v);

            if v14 == "<" then
                local v15, v16;
                local v10, v15, v16;
                local v17 = 0;

                while true do
                    if v17 == 0 then
                        v17 = -1;
                        v15 = string.find(p9, ">", v10, true);

                        if v15 == nil then
                            error("Malformed input: tag not closed.");
                        end;

                        v16 = p9:sub(v10, v15);

                        if v16 == "<br>" then
                            v17 = 1;
                            continue;
                        end;

                        if v16:sub(2, 4) ~= "img" then
                            if v16:sub(1, 2) == "</" then
                                table.remove(v13);
                            else
                                table.insert(v13, v16);
                            end;

                            v17 = 2;
                            continue;
                        end;

                        if #v11 > 0 then
                            table.insert(v12, v11);
                            v11 = {};
                        end;

                        local v18 = v16:match("id%s*=%s*\'([^\']+)\'") or v16:match("id%s*=%s*\"([^\"]+)\"");

                        if not v18 then
                            error("Missing id attribute in image tag.");
                        end;

                        local v19 = tonumber(v18);

                        if not v19 then
                            error("Invalid id attribute in image tag.");
                        end;

                        local v20 = v16:match("color%s*=%s*\'([^\']+)\'") or v16:match("color%s*=%s*\"([^\"]+)\"");
                        local v21 = nil;

                        if v20 then
                            local v22 = v20:gsub("#", "");

                            if #v22 == 6 then
                                local v23 = v22:sub(1, 2);
                                local v24 = tonumber(v23, 16) / 255;
                                local v25 = v22:sub(3, 4);
                                local v26 = tonumber(v25, 16) / 255;
                                local v27 = v22:sub(5, 6);
                                local v28 = tonumber(v27, 16) / 255;
                                v21 = Color3.new(v24, v26, v28);
                            end;
                        end;

                        local v29 = v16:match("size%s*=%s*\'([^\']+)\'") or v16:match("size%s*=%s*\"([^\"]+)\"");
                        local v30 = nil;

                        if v29 then
                            local v31, v32 = v29:match("(%d+)%s*,%s*(%d+)");

                            if v31 and v32 then
                                v30 = Vector2.new(tonumber(v31), (tonumber(v32)));
                            end;
                        end;

                        local v33 = {
                            id = v19,
                            color = v21,
                            size = v30,
                            tags = { table.unpack(v13) }
                        };
                        table.insert(v12, v33);
                        v10 = v15 + 1;
                        v17 = 3;
                        continue;
                    elseif v17 == 1 then
                        v17 = -1;
                        table.insert(v12, {
                            {
                                character = v16,
                                tags = {}
                            }
                        });
                        v17 = 2;
                        continue;
                    elseif v17 == 2 then
                        v17 = -1;
                        v10 = v15 + 1;
                        v17 = 3;
                        continue;
                    elseif v17 == 3 then
                        v17 = -1;
                        break;
                    else
                        break;
                    end;
                end;
            elseif v14:match("%s") then
                if #v11 > 0 then
                    table.insert(v12, v11);
                    v11 = {};
                end;

                v10 = v + 1;
            else
                local v34 = {
                    character = v14,
                    tags = { table.unpack(v13) }
                };
                table.insert(v11, v34);
                v10 = v + 1;
            end;
        end;
    end;

    if #v11 > 0 then
        table.insert(v12, v11);
    end;

    return v12;
end;

local function getAnimationInfo(p35: string, p36: any) -- Line: 326
    local v37 = nil;

    for i in p35:gmatch("<animation([^>]*)>") do
        v37 = i;
    end;

    if not v37 then
        return {
            TimeBetweenStep = p36.DefaultTimeBetweenStep,
            AnimationLength = p36.FallbackAnimationLength,
            Repeats = p36.FallbackAnimationRepeats,
            AnimationStyle = p36.FallbackAnimationStyle,
            AnimationStep = p36.FallbackAnimationStep
        };
    end;

    local v38 = v37:match("animationLength%s*=%s*\"(.-)\"") or v37:match("animationLength%s*=%s*\'(.-)\'");
    local v39;

    if v38 and tonumber(v38) then
        v39 = tonumber(v38);
    else
        v39 = p36.FallbackAnimationLength;
    end;

    local v40 = v37:match("style%s*=%s*\"(.-)\"") or (v37:match("style%s*=%s*\'(.-)\'") or p36.FallbackAnimationStyle);
    local v41 = v37:match("step%s*=%s*\"(.-)\"") or (v37:match("step%s*=%s*\'(.-)\'") or p36.FallbackAnimationStep);
    local v42 = v37:match("timeBetweenStep%s*=%s*\"(.-)\"") or v37:match("timeBetweenStep%s*=%s*\'(.-)\'");
    local v43;

    if v42 and tonumber(v42) then
        v43 = tonumber(v42);
    else
        v43 = p36.DefaultTimeBetweenStep;
    end;

    if v41 ~= "letter" and (v41 ~= "word" and v41 ~= "all") then
        error((`Invalid step provided ('{v41}'). Valid options: 'letter', 'word', 'all'`));
    end;

    return {
        TimeBetweenStep = v43,
        AnimationLength = v39,
        AnimationStep = v41,
        Repeats = v37:find("repeats") ~= nil,
        AnimationStyle = v40:lower()
    };
end;

local function reconcileProperties(p44) -- Line: 375
    -- upvalues: u3 (copy)
    local v45 = p44 or {};

    for i, v in u3 do
        v45[i] = v45[i] or v;
    end;

    return v45;
end;

local function stepAnimationQueue(p46: table, p47: any, p48: number, p49: boolean?) -- Line: 383
    -- upvalues: u2 (copy)
    for i = #p46, 1, -1 do
        local v50 = p46[i];
        local v51 = u2[v50.animationInfo.AnimationStyle];

        if not v51 then
            warn("No animation style found for: ", v50.animationInfo.AnimationStyle, ", defaulting to \'appear\'");
            v51 = u2.appear;
        end;

        if p49 and v50.animationInfo.Repeats == false then
            v50.elapsedT = v50.animationInfo.AnimationLength;
        else
            v50.elapsedT = v50.elapsedT + p48;
        end;

        local math_min_ret = math.min(v50.elapsedT / v50.animationInfo.AnimationLength, 1);
        v51(v50.character, math_min_ret, p47, {});
        local v52;

        if v50.animationInfo.AnimationLength == 0 or math_min_ret >= 1 then
            if v50.animationInfo.Repeats then
                v50.elapsedT = 0;
                v52 = i;
            else
                table.remove(p46, i);
                v52 = i;
            end;
        else
            v52 = i;
        end;
    end;
end;

local function pushCharacter() -- Line: 415
end;

function u1.new(p53, p54, p55, p56) -- Line: 420
    -- upvalues: u3 (copy), UIListLayout (copy), RunService (copy), stepAnimationQueue (copy), u1 (copy)
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.Position = UDim2.fromScale(0.5, 0.5);
    Frame.BackgroundTransparency = 1;
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.Parent = p53;
    local u57 = p55 or {};

    for i, v in u3 do
        u57[i] = u57[i] or v;
    end;

    local v58 = UIListLayout:Clone();
    v58.VerticalAlignment = u57.VerticalAlignment;
    v58.Padding = UDim.new(0, u57.LineSpacing);
    v58.Parent = Frame;
    local u59 = {};
    local v62 = {
        destroyed = false,
        visible = true,
        paused = false,
        text = p54,
        letterCallback = p56,
        animateQueue = u59,
        animateConnection = RunService.Stepped:Connect(function(p60, p61) -- Line: 447
            -- upvalues: stepAnimationQueue (ref), u59 (copy), u57 (copy)
            stepAnimationQueue(u59, u57, p61);
        end),
        properties = u57,
        container = Frame,
        characters = {}
    };
    local v63 = setmetatable(v62, u1);
    v63:Redraw();

    return v63;
end;

function u1.Redraw(p64) -- Line: 463
    -- upvalues: getUIScale (copy), LineFrameTemplate (copy), TextService (copy), u3 (copy), WordFrameTemplate (copy), CharacterFrame (copy), ImageFrame (copy), parseRichText (copy)
    if p64.destroyed then
        error("RichText instance is destroyed.");
    end;

    p64:Stop(true);
    local container = p64.container;
    local characters = p64.characters;
    local properties = p64.properties;
    table.clear(characters);

    for _, child in container:GetChildren() do
        if not child:IsA("UIListLayout") then
            child:Destroy();
        end;
    end;

    local AbsoluteSize = container.AbsoluteSize;
    local u65 = getUIScale(container);
    local u66 = AbsoluteSize / u65.Scale;
    local DefaultTextSize = properties.DefaultTextSize;
    local DefaultFont = properties.DefaultFont;
    local u67 = nil;
    local u68 = 0;

    local function createLine() -- Line: 492
        -- upvalues: u68 (ref), LineFrameTemplate (ref), DefaultTextSize (copy), u66 (copy), properties (copy), container (copy), u67 (ref)
        u68 = u68 + 1;
        local v69 = LineFrameTemplate:Clone();
        v69.Name = `Line_{u68}`;
        v69.LayoutOrder = u68;
        v69.Size = UDim2.fromScale(1, DefaultTextSize / u66.Y);
        v69.UIListLayout.Padding = UDim.new(0, properties.WordSpacing);
        v69.UIListLayout.HorizontalAlignment = properties.HorizontalAlignment;
        v69.Parent = container;
        u67 = v69;
    end;

    createLine();

    local function getFontFromTags(p70: table) -- Line: 507
        -- upvalues: DefaultFont (copy), DefaultTextSize (copy)
        local v71 = nil;
        local v72 = nil;

        for _, v in p70 do
            if not v71 then
                local v73 = v:match("face=[\"\'](.-)[\"\']");

                if v73 then
                    v71 = Font.fromName(v73);
                else
                    local v74 = v:match("family=[\"\'](.-)[\"\']");

                    if v74 then
                        v71 = Font.new(v74);
                    end;
                end;
            end;

            if not v72 then
                local v75 = v:match("size=[\"\'](.-)[\"\']");

                if v75 then
                    v72 = tonumber(v75) or v75;
                end;
            end;

            if v71 and v72 then
                break;
            end;
        end;

        return v71 or DefaultFont, v72 or DefaultTextSize;
    end;

    local function getCharacterLengthsFromRichChar(p76: table) -- Line: 545
        -- upvalues: getFontFromTags (copy), u66 (copy), TextService (ref), u3 (ref), properties (copy)
        local v77 = {};

        for _, v in p76 do
            local v78, v79 = getFontFromTags(v.tags);
            local character = v.character;
            local GetTextBoundsParams = Instance.new("GetTextBoundsParams");
            GetTextBoundsParams.Font = v78;
            GetTextBoundsParams.Text = character;
            GetTextBoundsParams.Width = u66.X;
            GetTextBoundsParams.Size = v79;
            local success, result = pcall(function() -- Line: 557
                -- upvalues: TextService (ref), GetTextBoundsParams (copy)
                return TextService:GetTextBoundsAsync(GetTextBoundsParams).X;
            end);

            if success == false then
                local DefaultFont2 = u3.DefaultFont;
                properties.DefaultFont = DefaultFont2;
                result = TextService:GetTextSize(character, v79, DefaultFont2.Family:match("/families/(.+)%.json"), Vector2.new(u66.X, v79)).X;
            end;

            table.insert(v77, result);
        end;

        return v77;
    end;

    local function addFrameToLine(p80: userdata, p81: number) -- Line: 579
        -- upvalues: u67 (ref), u65 (copy), AbsoluteSize (copy), createLine (copy)
        if u67.UIListLayout.AbsoluteContentSize.X + p81 * u65.Scale > AbsoluteSize.X then
            createLine();
        end;

        p80.LayoutOrder = #u67:GetChildren();
        p80.Parent = u67;
    end;

    local function addTagsToText(p82: string, p83: table) -- Line: 588
        local v84 = table.concat(p83) .. p82;

        for i = #p83, 1, -1 do
            local v85 = p83[i]:match("^<%s*(%w+)");
            local v86;

            if v85 then
                v84 = v84 .. "</" .. v85 .. ">";
                v86 = i;
            else
                v86 = i;
            end;
        end;

        return v84;
    end;

    local function addWord(p87: table, p88: number) -- Line: 601
        -- upvalues: createLine (copy), getCharacterLengthsFromRichChar (copy), WordFrameTemplate (ref), properties (copy), u66 (copy), getFontFromTags (copy), addTagsToText (copy), CharacterFrame (ref), characters (copy), u67 (ref), u65 (copy), AbsoluteSize (copy)
        if p87[1].character == "<br>" then
            createLine();

            return;
        end;

        local v89 = getCharacterLengthsFromRichChar(p87);
        local v90 = 0;

        for _, v in v89 do
            v90 = v90 + v;
        end;

        local v91 = WordFrameTemplate:Clone();
        v91.UIListLayout.Padding = UDim.new(0, properties.LetterSpacing);
        local v92 = v90 + (#v89 - 1) * v91.UIListLayout.Padding.Offset;
        v91.Name = `Word_{p88}`;
        v91.Size = UDim2.fromScale(v92 / u66.X, 1);
        local v93 = 0;
        local v94 = 0;

        for i, v in p87 do
            local v95, v96 = getFontFromTags(v.tags);
            local character = v.character;
            local v97 = v89[i];
            v93 = math.max(v93, v96);
            local v98 = addTagsToText(character, v.tags);
            local v99 = v97 / v92;
            local v100 = CharacterFrame:Clone();
            v100.Size = UDim2.fromScale(v99, 1);
            v100.Name = `Char_{i}`;
            v100.Parent = v91;
            local TextLabel = v100.TextLabel;
            TextLabel.Text = v98;
            TextLabel.TextSize = v96;
            TextLabel.TextColor3 = properties.TextColor;
            TextLabel.TextStrokeColor3 = properties.TextStrokeColor;
            TextLabel.TextTransparency = properties.Transparency;
            TextLabel.TextStrokeTransparency = properties.TextStrokeTransparency;
            TextLabel.FontFace = v95;
            TextLabel.Visible = true;
            v100:SetAttribute("endOfWord", i == #p87);
            table.insert(characters, v100);
            v94 = v94 + v99;
        end;

        if u67.UIListLayout.AbsoluteContentSize.X + v92 * u65.Scale > AbsoluteSize.X then
            createLine();
        end;

        v91.LayoutOrder = #u67:GetChildren();
        v91.Parent = u67;
        u67.Size = UDim2.fromScale(1, (math.max(v93 / u66.Y, u67.Size.Y.Scale)));
    end;

    local function addImage(p101: table) -- Line: 670
        -- upvalues: ImageFrame (ref), properties (copy), addTagsToText (copy), characters (copy), u67 (ref), u65 (copy), AbsoluteSize (copy), createLine (copy), u66 (copy)
        local v102 = ImageFrame:Clone();
        v102.ImageLabel.Image = `rbxassetid://{p101.id}`;
        v102.ImageLabel.ImageTransparency = properties.Transparency;
        v102.TextLabel.Text = addTagsToText("", p101.tags);

        if p101.color then
            v102.ImageLabel.ImageColor3 = p101.color;
        end;

        if p101.size then
            v102.UIAspectRatioConstraint:Destroy();
            v102.Size = UDim2.fromOffset(p101.size.X, p101.size.Y);
        end;

        table.insert(characters, v102);

        if u67.UIListLayout.AbsoluteContentSize.X + u67.AbsoluteSize.Y * u65.Scale > AbsoluteSize.X then
            createLine();
        end;

        v102.LayoutOrder = #u67:GetChildren();
        v102.Parent = u67;

        if p101.size then
            u67.Size = UDim2.fromScale(1, (math.max(p101.size.Y / u66.Y, u67.Size.Y.Scale)));
        end;
    end;

    local v103 = 0;

    for _, v in parseRichText(p64.text) do
        v103 = v103 + 1;

        if v[1] then
            addWord(v, v103);
        else
            addImage(v);
        end;
    end;

    p64:Reset();
end;

local function popCharacter(p104: any, p105: number, p106: boolean, p107: number?) -- Line: 716
    -- upvalues: getAnimationInfo (copy)
    local v108 = 0;
    local animateQueue = p104.animateQueue;
    local properties = p104.properties;

    if p104.characters[p105] ~= nil then
        local v109 = p104.characters[p105];
        p105 = p105 + 1;
        local v110 = getAnimationInfo(v109.TextLabel.Text, properties);
        local v111 = {
            character = v109,
            animationInfo = v110,
            elapsedT = math.abs(-(p107 or 0) % v110.AnimationLength)
        };
        table.insert(animateQueue, v111);

        if v110.AnimationStep == "all" then
            while true do
                local v112 = p104.characters[p105];
                local v113 = getAnimationInfo(v112.TextLabel.Text, properties);

                if v113.AnimationStep ~= "all" then
                    break;
                end;

                p105 = p105 + 1;
                table.insert(animateQueue, {
                    character = v112,
                    animationInfo = v113,
                    elapsedT = -(p107 or 0) % v113.AnimationLength
                });
            end;

            if p106 and p104.letterCallback then
                p104.letterCallback();
            end;

            v108 = v110.TimeBetweenStep;
        elseif v110.AnimationStep == "word" then
            while p104.characters[p105] do
                local v114 = p104.characters[p105];
                p105 = p105 + 1;
                local v115 = getAnimationInfo(v114.TextLabel.Text, properties);
                table.insert(animateQueue, {
                    character = v114,
                    animationInfo = v115,
                    elapsedT = -(p107 or 0) % v115.AnimationLength
                });

                if v114:GetAttribute("endOfWord") then
                    v108 = v115.TimeBetweenStep;

                    if p104.letterCallback then
                        p104.letterCallback();
                    end;

                    break;
                end;
            end;
        else
            if p106 and p104.letterCallback then
                p104.letterCallback();
            end;

            v108 = v110.TimeBetweenStep;
        end;
    end;

    return v108, p105;
end;

function u1.Play(u116, p117) -- Line: 794
    -- upvalues: RunService (copy), popCharacter (copy)
    if u116.destroyed then
        error("RichText instance is destroyed.");
    end;

    u116:Reset();
    u116.paused = false;
    local u118 = -1;
    local u119 = 1;
    table.clear(u116.animateQueue);
    local _ = u116.properties;
    u116.playConnection = RunService.Stepped:Connect(function(p120, p121) -- Line: 809
        -- upvalues: u116 (copy), u118 (ref), u119 (ref), popCharacter (ref)
        if u116.paused then
            return;
        end;

        u118 = u118 - p121;

        if u118 < 0 and u116.characters[u119] ~= nil then
            local v122, v123 = popCharacter(u116, u119, true);
            u118 = v122;
            u119 = v123;
        end;

        if u116.characters[u119] == nil then
            u116.playConnection:Disconnect();
            u116.playConnection = nil;
        end;
    end);

    if not p117 then
        return;
    end;

    while u116.playConnection do
        task.wait();
    end;
end;

function u1.Pause(p124, p125) -- Line: 832
    if p124.destroyed then
        error("RichText instance is destroyed.");
    end;

    if p124.playConnection == nil then
        warn("RichText is not currently playing an animation. Did you mean to call this?");

        return;
    end;

    if p125 == nil then
        p124.paused = not p124.paused;

        return;
    end;

    p124.paused = p125;
end;

function u1.Stop(p126, p127) -- Line: 849
    if p126.playConnection == nil then
        if p127 ~= true then
            warn("RichText is not currently playing an animation. Did you mean to call this?");
        end;

        return;
    end;

    p126.playConnection:Disconnect();
    p126.playConnection = nil;
end;

function u1.Toggle(p128, p129) -- Line: 862
    if p128.destroyed then
        error("RichText instance is destroyed.");
    end;

    p128.visible = not p129;
    p128.container.Visible = not p129;
end;

function u1.Skip(p130) -- Line: 871
    -- upvalues: popCharacter (copy)
    if p130.destroyed then
        error("RichText instance is destroyed.");
    elseif p130.visible == false then
        warn("This RichText isn\'t visible. Did you mean to call this?");
    end;

    p130:Stop(true);
    local v131 = 0;

    for i = #p130.animateQueue + 1, #p130.characters do
        v131 = v131 + popCharacter(p130, i, false, v131);
        local _ = i;
    end;

    for _, v in p130.characters do
        v.Visible = true;
    end;
end;

function u1.Reset(p132) -- Line: 891
    -- upvalues: stepAnimationQueue (copy)
    if p132.destroyed then
        error("RichText instance is destroyed.");
    end;

    p132:Stop(true);
    stepAnimationQueue(p132.animateQueue, p132.properties, 0, true);
    table.clear(p132.animateQueue);

    for _, v in p132.characters do
        v.Visible = false;
    end;

    p132:Toggle(false);
end;

function u1.Destroy(p133) -- Line: 911
    if p133.destroyed then
        warn("RichText instance already destroyed!");

        return;
    end;

    p133.destroyed = true;

    if p133.animateConnection then
        p133.animateConnection:Disconnect();
    end;

    p133:Stop(true);
    p133.container:Destroy();
end;

return u1;