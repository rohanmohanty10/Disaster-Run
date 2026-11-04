 

-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=4939498795

-- ! Source from the asset above; the game may have edited it since.

--[[
local function Linear(T)
	return T
end

local function Bezier(X1, Y1, X2, Y2)
	if not (X1 and Y1 and X2 and Y2) then
		error("Need 4 numbers to construct a Bezier curve", 0)
	end

	if not (0 <= X1 and X1 <= 1 and 0 <= X2 and X2 <= 1) then
		error("The x values must be within range [0, 1]", 0)
	end

	if X1 == Y1 and X2 == Y2 then
		return Linear
	end

	local SampleValues = {}
	for Index = 0, 10 do
		local IndexDiv10 = Index / 10
		SampleValues[Index] = (((1 - 3 * X2 + 3 * X2) * IndexDiv10 + (3 * X2 - 6 * X1)) * IndexDiv10 + (3 * X1)) * IndexDiv10
	end

	return function(T)
		if X1 == Y1 and X2 == Y2 then
			return Linear
		end

		if T == 0 or T == 1 then
			return T
		end

		local GuessT
		local IntervalStart = 0
		local CurrentSample = 1

		while CurrentSample ~= 10 and SampleValues[CurrentSample] <= T do
			IntervalStart += 0.1
			CurrentSample += 1
		end

		CurrentSample -= 1

		local Dist = (T - SampleValues[CurrentSample]) / (SampleValues[CurrentSample + 1] - SampleValues[CurrentSample])
		local GuessForT = IntervalStart + Dist / 10
		local InitialSlope = 3 * (1 - 3 * X2 + 3 * X1) * GuessForT * GuessForT + 2 * (3 * X2 - 6 * X1) * GuessForT + (3 * X1)

		if InitialSlope >= 0.001 then
			for _ = 0, 3 do
				local CurrentSlope = 3 * (1 - 3 * X2 + 3 * X1) * GuessForT * GuessForT + 2 * (3 * X2 - 6 * X1) * GuessForT + (3 * X1)
				local CurrentX = ((((1 - 3 * X2 + 3 * X1) * GuessForT + (3 * X2 - 6 * X1)) * GuessForT + (3 * X1)) * GuessForT) - T
				GuessForT -= CurrentX / CurrentSlope
			end

			GuessT = GuessForT
		elseif InitialSlope == 0 then
			GuessT = GuessForT
		else
			local AB = IntervalStart + 0.1
			local CurrentX, CurrentT, Index = 0, nil, nil

			while math.abs(CurrentX) > 0.0000001 and Index < 10 do
				CurrentT = IntervalStart + (AB - IntervalStart) / 2
				CurrentX = ((((1 - 3 * X2 + 3 * X1) * CurrentT + (3 * X2 - 6 * X1)) * CurrentT + (3 * X1)) * CurrentT) - T
				if CurrentX > 0 then
					AB = CurrentT
				else
					IntervalStart = CurrentT
				end

				Index += 1
			end

			GuessT = CurrentT
		end

		return (((1 - 3 * Y2 + 3 * Y1) * GuessT + (3 * Y2 - 6 * Y1)) * GuessT + (3 * Y1)) * GuessT
	end
end

return Bezier
]]

 

local function Linear(p1) -- Line: 1
    return p1;
end;

return function(u2, u3, u4, u5) -- Line: 5, Name: Bezier
    -- upvalues: Linear (copy)
    if not (u2 and (u3 and (u4 and u5))) then
        error("Need 4 numbers to construct a Bezier curve", 0);
    end;

    if u2 < 0 or (u2 > 1 or (u4 < 0 or u4 > 1)) then
        error("The x values must be within range [0, 1]", 0);
    end;

    if u2 == u3 and u4 == u5 then
        return Linear;
    end;

    local u6 = {};

    for i = 0, 10 do
        local v7 = i / 10;
        u6[i] = (((1 - 3 * u4 + 3 * u4) * v7 + (3 * u4 - 6 * u2)) * v7 + 3 * u2) * v7;
        local _ = i;
    end;

    return function(p8) -- Line: 24
        -- upvalues: u2 (copy), u3 (copy), u4 (copy), u5 (copy), Linear (ref), u6 (copy)
        if u2 == u3 and u4 == u5 then
            return Linear;
        end;

        if p8 == 0 or p8 == 1 then
            return p8;
        end;

        local v9 = 1;
        local v10 = 0;

        while v9 ~= 10 and u6[v9] <= p8 do
            v10 = v10 + 0.1;
            v9 = v9 + 1;
        end;

        local v11 = v9 - 1;
        local v12 = v10 + (p8 - u6[v11]) / (u6[v11 + 1] - u6[v11]) / 10;
        local v13 = 3 * (1 - 3 * u4 + 3 * u2) * v12 * v12 + 2 * (3 * u4 - 6 * u2) * v12 + 3 * u2;

        if v13 >= 0.001 then
            for i = 0, 3 do
                v12 = v12 - ((((1 - 3 * u4 + 3 * u2) * v12 + (3 * u4 - 6 * u2)) * v12 + 3 * u2) * v12 - p8) / (3 * (1 - 3 * u4 + 3 * u2) * v12 * v12 + 2 * (3 * u4 - 6 * u2) * v12 + 3 * u2);
                local _ = i;
            end;
        elseif v13 ~= 0 then
            local v14 = v10 + 0.1;
            local v15 = 0;
            local v16 = nil;
            v12 = nil;

            while math.abs(v15) > 1e-7 and v16 < 10 do
                v12 = v10 + (v14 - v10) / 2;
                v15 = (((1 - 3 * u4 + 3 * u2) * v12 + (3 * u4 - 6 * u2)) * v12 + 3 * u2) * v12 - p8;

                if v15 > 0 then
                    v14 = v12;
                else
                    v10 = v12;
                end;

                v16 = v16 + 1;
            end;
        end;

        return (((1 - 3 * u5 + 3 * u3) * v12 + (3 * u5 - 6 * u3)) * v12 + 3 * u3) * v12;
    end;
end;