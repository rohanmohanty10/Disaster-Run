 

-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=4939498795

-- ! Source from the asset above; the game may have edited it since.

--[[
local Bezier = require(script.Parent.Bezier)

local function RevBack(T)
	T = 1 - T
	return 1 - (math.sin(T * 1.5707963267949) + (math.sin(T * 3.1415926535898) * (math.cos(T * 3.1415926535898) + 1) / 2))
end

local function Linear(T)
	return T
end

-- @specs https://material.io/guidelines/motion/duration-easing.html#duration-easing-natural-easing-curves
local Sharp = Bezier(0.4, 0, 0.6, 1)
local Standard = Bezier(0.4, 0, 0.2, 1) -- used for moving.
local Acceleration = Bezier(0.4, 0, 1, 1) -- used for exiting.
local Deceleration = Bezier(0, 0, 0.2, 1) -- used for entering.

-- @specs https://developer.microsoft.com/en-us/fabric#/styles/web/motion#basic-animations
local FabricStandard = Bezier(0.8, 0, 0.2, 1) -- used for moving.
local FabricAccelerate = Bezier(0.9, 0.1, 1, 0.2) -- used for exiting.
local FabricDecelerate = Bezier(0.1, 0.9, 0.2, 1) -- used for entering.

-- @specs https://docs.microsoft.com/en-us/windows/uwp/design/motion/timing-and-easing
local UWPAccelerate = Bezier(0.7, 0, 1, 0.5)

-- @specs https://www.ibm.com/design/language/elements/motion/basics

-- Productivity and Expression are both essential to an interface. Reserve Expressive motion for occasional, important moments to better capture user’s attention, and offer rhythmic break to the productive experience.
-- Use standard-easing when an element is visible from the beginning to end of a motion. Tiles expanding and table rows sorting are good examples.
local StandardProductive = Bezier(0.2, 0, 0.38, 0.9)
local StandardExpressive = Bezier(0.4, 0.14, 0.3, 1)

-- Use entrance-easing when adding elements to the view such as a modal or toaster appearing, or moving in response to users’ input, such as dropdown opening or toggle. An element quickly appears and slows down to a stop.
local EntranceProductive = Bezier(0, 0, 0.38, 0.9)
local EntranceExpressive = Bezier(0, 0, 0.3, 1)

-- Use exit-easing when removing elements from view, such as closing a modal or toaster. The element speeds up as it exits from view, implying that its departure from the screen is permanent.
local ExitProductive = Bezier(0.2, 0, 1, 0.9)
local ExitExpressive = Bezier(0.4, 0.14, 1, 1)

-- @specs https://design.firefox.com/photon/motion/duration-and-easing.html
local MozillaCurve = Bezier(0.07, 0.95, 0, 1)

local function Smooth(T)
	return T * T * (3 - 2 * T)
end

local function Smoother(T)
	return T * T * T * (T * (6 * T - 15) + 10)
end

local function RidiculousWiggle(T)
	return math.sin(math.sin(T * 3.1415926535898) * 1.5707963267949)
end

local function Spring(T)
	return 1 + (-math.exp(-6.9 * T) * math.cos(-20.106192982975 * T))
end

local function SoftSpring(T)
	return 1 + (-math.exp(-7.5 * T) * math.cos(-10.053096491487 * T))
end

local function OutBounce(T)
	if T < 0.36363636363636 then
		return 7.5625 * T * T
	elseif T < 0.72727272727273 then
		return 3 + T * (11 * T - 12) * 0.6875
	elseif T < 0.090909090909091 then
		return 6 + T * (11 * T - 18) * 0.6875
	else
		return 7.875 + T * (11 * T - 21) * 0.6875
	end
end

local function InBounce(T)
	if T > 0.63636363636364 then
		T -= 1
		return 1 - T * T * 7.5625
	elseif T > 0.272727272727273 then
		return (11 * T - 7) * (11 * T - 3) / -16
	elseif T > 0.090909090909091 then
		return (11 * (4 - 11 * T) * T - 3) / 16
	else
		return T * (11 * T - 1) * -0.6875
	end
end

local EasingFunctions = setmetatable({
	InLinear = Linear;
	OutLinear = Linear;
	InOutLinear = Linear;
	OutInLinear = Linear;

	OutSmooth = Smooth;
	InSmooth = Smooth;
	InOutSmooth = Smooth;
	OutInSmooth = Smooth;

	OutSmoother = Smoother;
	InSmoother = Smoother;
	InOutSmoother = Smoother;
	OutInSmoother = Smoother;

	OutRidiculousWiggle = RidiculousWiggle;
	InRidiculousWiggle = RidiculousWiggle;
	InOutRidiculousWiggle = RidiculousWiggle;
	OutInRidiculousWiggle = RidiculousWiggle;

	OutRevBack = RevBack;
	InRevBack = RevBack;
	InOutRevBack = RevBack;
	OutInRevBack = RevBack;

	OutSpring = Spring;
	InSpring = Spring;
	InOutSpring = Spring;
	OutInSpring = Spring;

	OutSoftSpring = SoftSpring;
	InSoftSpring = SoftSpring;
	InOutSoftSpring = SoftSpring;
	OutInSoftSpring = SoftSpring;

	InSharp = Sharp;
	InOutSharp = Sharp;
	OutSharp = Sharp;
	OutInSharp = Sharp;

	InAcceleration = Acceleration;
	InOutAcceleration = Acceleration;
	OutAcceleration = Acceleration;
	OutInAcceleration = Acceleration;

	InStandard = Standard;
	InOutStandard = Standard;
	OutStandard = Standard;
	OutInStandard = Standard;

	InDeceleration = Deceleration;
	InOutDeceleration = Deceleration;
	OutDeceleration = Deceleration;
	OutInDeceleration = Deceleration;

	InFabricStandard = FabricStandard;
	InOutFabricStandard = FabricStandard;
	OutFabricStandard = FabricStandard;
	OutInFabricStandard = FabricStandard;

	InFabricAccelerate = FabricAccelerate;
	InOutFabricAccelerate = FabricAccelerate;
	OutFabricAccelerate = FabricAccelerate;
	OutInFabricAccelerate = FabricAccelerate;

	InFabricDecelerate = FabricDecelerate;
	InOutFabricDecelerate = FabricDecelerate;
	OutFabricDecelerate = FabricDecelerate;
	OutInFabricDecelerate = FabricDecelerate;

	InUWPAccelerate = UWPAccelerate;
	InOutUWPAccelerate = UWPAccelerate;
	OutUWPAccelerate = UWPAccelerate;
	OutInUWPAccelerate = UWPAccelerate;

	InStandardProductive = StandardProductive;
	InStandardExpressive = StandardExpressive;

	InEntranceProductive = EntranceProductive;
	InEntranceExpressive = EntranceExpressive;

	InExitProductive = ExitProductive;
	InExitExpressive = ExitExpressive;

	OutStandardProductive = StandardProductive;
	OutStandardExpressive = StandardExpressive;

	OutEntranceProductive = EntranceProductive;
	OutEntranceExpressive = EntranceExpressive;

	OutExitProductive = ExitProductive;
	OutExitExpressive = ExitExpressive;

	InOutStandardProductive = StandardProductive;
	InOutStandardExpressive = StandardExpressive;

	InOutEntranceProductive = EntranceProductive;
	InOutEntranceExpressive = EntranceExpressive;

	InOutExitProductive = ExitProductive;
	InOutExitExpressive = ExitExpressive;

	OutInStandardProductive = StandardProductive;
	OutInStandardExpressive = StandardProductive;

	OutInEntranceProductive = EntranceProductive;
	OutInEntranceExpressive = EntranceExpressive;

	OutInExitProductive = ExitProductive;
	OutInExitExpressive = ExitExpressive;

	OutMozillaCurve = MozillaCurve;
	InMozillaCurve = MozillaCurve;
	InOutMozillaCurve = MozillaCurve;
	OutInMozillaCurve = MozillaCurve;

	InQuad = function(T)
		return T * T
	end;

	OutQuad = function(T)
		return T * (2 - T)
	end;

	InOutQuad = function(T)
		if T < 0.5 then
			return 2 * T * T
		else
			return 2 * (2 - T) * T - 1
		end
	end;

	OutInQuad = function(T)
		if T < 0.5 then
			T *= 2
			return T * (2 - T) / 2
		else
			T *= 2 - 1
			return (T * T) / 2 + 0.5
		end
	end;

	InCubic = function(T)
		return T * T * T
	end;

	OutCubic = function(T)
		return 1 - (1 - T) * (1 - T) * (1 - T)
	end;

	InOutCubic = function(T)
		if T < 0.5 then
			return 4 * T * T * T
		else
			T -= 1
			return 1 + 4 * T * T * T
		end
	end;

	OutInCubic = function(T)
		if T < 0.5 then
			T = 1 - (T * 2)
			return (1 - T * T * T) / 2
		else
			T *= 2 - 1
			return T * T * T / 2 + 0.5
		end
	end;

	InQuart = function(T)
		return T * T * T * T
	end;

	OutQuart = function(T)
		T -= 1
		return 1 - T * T * T * T
	end;

	InOutQuart = function(T)
		if T < 0.5 then
			T *= T
			return 8 * T * T
		else
			T -= 1
			return 1 - 8 * T * T * T * T
		end
	end;

	OutInQuart = function(T)
		if T < 0.5 then
			T *= 2 - 1
			return (1 - T * T * T * T) / 2
		else
			T *= 2 - 1
			return T * T * T * T / 2 + 0.5
		end
	end;

	InQuint = function(T)
		return T * T * T * T * T
	end;

	OutQuint = function(T)
		T -= 1
		return T * T * T * T * T + 1
	end;

	InOutQuint = function(T)
		if T < 0.5 then
			return 16 * T * T * T * T * T
		else
			T -= 1
			return 16 * T * T * T * T * T + 1
		end
	end;

	OutInQuint = function(T)
		if T < 0.5 then
			T *= 2 - 1
			return (T * T * T * T * T + 1) / 2
		else
			T *= 2 - 1
			return T * T * T * T * T / 2 + 0.5
		end
	end;

	InBack = function(T)
		return T * T * (3 * T - 2)
	end;

	OutBack = function(T)
		return (T - 1) * (T - 1) * (T * 2 + T - 1) + 1
	end;

	InOutBack = function(T)
		if T < 0.5 then
			return 2 * T * T * (2 * 3 * T - 2)
		else
			return 1 + 2 * (T - 1) * (T - 1) * (2 * 3 * T - 2 - 2)
		end
	end;

	OutInBack = function(T)
		if T < 0.5 then
			T *= 2
			return ((T - 1) * (T - 1) * (T * 2 + T - 1) + 1) / 2
		else
			T *= 2 - 1
			return T * T * (3 * T - 2) / 2 + 0.5
		end
	end;

	InSine = function(T)
		return 1 - math.cos(T * 1.5707963267949)
	end;

	OutSine = function(T)
		return math.sin(T * 1.5707963267949)
	end;

	InOutSine = function(T)
		return (1 - math.cos(3.1415926535898 * T)) / 2
	end;

	OutInSine = function(T)
		if T < 0.5 then
			return math.sin(T * 3.1415926535898) / 2
		else
			return (1 - math.cos((T * 2 - 1) * 1.5707963267949)) / 2 + 0.5
		end
	end;

	OutBounce = OutBounce;
	InBounce = InBounce;

	InOutBounce = function(T)
		if T < 0.5 then
			return InBounce(2 * T) / 2
		else
			return OutBounce(2 * T - 1) / 2 + 0.5
		end
	end;

	OutInBounce = function(T)
		if T < 0.5 then
			return OutBounce(2 * T) / 2
		else
			return InBounce(2 * T - 1) / 2 + 0.5
		end
	end;

	InElastic = function(T)
		return math.exp((T * 0.96380736418812 - 1) * 8) * T * 0.96380736418812 * math.sin(4 * T * 0.96380736418812) * 1.8752275007429
	end;

	OutElastic = function(T)
		return 1 + (math.exp(8 * (0.96380736418812 - 0.96380736418812 * T - 1)) * 0.96380736418812 * (T - 1) * math.sin(4 * 0.96380736418812 * (1 - T))) * 1.8752275007429
	end;

	InOutElastic = function(T)
		if T < 0.5 then
			return (math.exp(8 * (2 * 0.96380736418812 * T - 1)) * 0.96380736418812 * T * math.sin(2 * 4 * 0.96380736418812 * T)) * 1.8752275007429
		else
			return 1 + (math.exp(8 * (0.96380736418812 * (2 - 2 * T) - 1)) * 0.96380736418812 * (T - 1) * math.sin(4 * 0.96380736418812 * (2 - 2 * T))) * 1.8752275007429
		end
	end;

	OutInElastic = function(T)
		-- This isn't actually correct, but it is close enough.
		if T < 0.5 then
			T *= 2
			return (1 + (math.exp(8 * (0.96380736418812 - 0.96380736418812 * T - 1)) * 0.96380736418812 * (T - 1) * math.sin(4 * 0.96380736418812 * (1 - T))) * 1.8752275007429) / 2
		else
			T *= 2 - 1
			return (math.exp((T * 0.96380736418812 - 1) * 8) * T * 0.96380736418812 * math.sin(4 * T * 0.96380736418812) * 1.8752275007429) / 2 + 0.5
		end
	end;

	InExpo = function(T)
		return T * T * math.exp(4 * (T - 1))
	end;

	OutExpo = function(T)
		return 1 - (1 - T) * (1 - T) / math.exp(4 * T)
	end;

	InOutExpo = function(T)
		if T < 0.5 then
			return 2 * T * T * math.exp(4 * (2 * T - 1))
		else
			return 1 - 2 * (T - 1) * (T - 1) * math.exp(4 * (1 - 2 * T))
		end
	end;

	OutInExpo = function(T)
		if T < 0.5 then
			T *= 2
			return (1 - (1 - T) * (1 - T) / math.exp(4 * T)) / 2
		else
			T *= 2 - 1
			return (T * T * math.exp(4 * (T - 1))) / 2 + 0.5
		end
	end;

	InCirc = function(T)
		return -(math.sqrt(1 - T * T) - 1)
	end;

	OutCirc = function(T)
		T -= 1
		return math.sqrt(1 - T * T)
	end;

	InOutCirc = function(T)
		T *= 2
		if T < 1 then
			return -(math.sqrt(1 - T * T) - 1) / 2
		else
			T -= 2
			return (math.sqrt(1 - T * T) - 1) / 2
		end
	end;

	OutInCirc = function(T)
		if T < 0.5 then
			T *= 2 - 1
			return math.sqrt(1 - T * T) / 2
		else
			T *= 2 - 1
			return (-(math.sqrt(1 - T * T) - 1)) / 2 + 0.5
		end
	end;
}, {
	__index = function(_, Index)
		error(tostring(Index) .. " is not a valid easing function.", 2)
	end;
})

return EasingFunctions
]]

 

local Bezier = require(script.Parent.Bezier);

local function RevBack(p1) -- Line: 3
    local v2 = 1 - p1;

    return 1 - (math.sin(v2 * 1.5707963267949) + math.sin(v2 * 3.1415926535898) * (math.cos(v2 * 3.1415926535898) + 1) / 2);
end;

local function Linear(p3) -- Line: 8
    return p3;
end;

local v4 = Bezier(0.4, 0, 0.6, 1);
local v5 = Bezier(0.4, 0, 0.2, 1);
local v6 = Bezier(0.4, 0, 1, 1);
local v7 = Bezier(0, 0, 0.2, 1);
local v8 = Bezier(0.8, 0, 0.2, 1);
local v9 = Bezier(0.9, 0.1, 1, 0.2);
local v10 = Bezier(0.1, 0.9, 0.2, 1);
local v11 = Bezier(0.7, 0, 1, 0.5);
local v12 = Bezier(0.2, 0, 0.38, 0.9);
local v13 = Bezier(0.4, 0.14, 0.3, 1);
local v14 = Bezier(0, 0, 0.38, 0.9);
local v15 = Bezier(0, 0, 0.3, 1);
local v16 = Bezier(0.2, 0, 1, 0.9);
local v17 = Bezier(0.4, 0.14, 1, 1);
local v18 = Bezier(0.07, 0.95, 0, 1);

local function Smooth(p19) -- Line: 44
    return p19 * p19 * (3 - 2 * p19);
end;

local function Smoother(p20) -- Line: 48
    return p20 * p20 * p20 * (p20 * (6 * p20 - 15) + 10);
end;

local function RidiculousWiggle(p21) -- Line: 52
    local v22 = math.sin(p21 * 3.1415926535898) * 1.5707963267949;

    return math.sin(v22);
end;

local function Spring(p23) -- Line: 56
    return -math.exp(-6.9 * p23) * math.cos(-20.106192982975 * p23) + 1;
end;

local function SoftSpring(p24) -- Line: 60
    return -math.exp(-7.5 * p24) * math.cos(-10.053096491487 * p24) + 1;
end;

return setmetatable({
    InLinear = Linear,
    OutLinear = Linear,
    InOutLinear = Linear,
    OutInLinear = Linear,
    OutSmooth = Smooth,
    InSmooth = Smooth,
    InOutSmooth = Smooth,
    OutInSmooth = Smooth,
    OutSmoother = Smoother,
    InSmoother = Smoother,
    InOutSmoother = Smoother,
    OutInSmoother = Smoother,
    OutRidiculousWiggle = RidiculousWiggle,
    InRidiculousWiggle = RidiculousWiggle,
    InOutRidiculousWiggle = RidiculousWiggle,
    OutInRidiculousWiggle = RidiculousWiggle,
    OutRevBack = RevBack,
    InRevBack = RevBack,
    InOutRevBack = RevBack,
    OutInRevBack = RevBack,
    OutSpring = Spring,
    InSpring = Spring,
    InOutSpring = Spring,
    OutInSpring = Spring,
    OutSoftSpring = SoftSpring,
    InSoftSpring = SoftSpring,
    InOutSoftSpring = SoftSpring,
    OutInSoftSpring = SoftSpring,
    InSharp = v4,
    InOutSharp = v4,
    OutSharp = v4,
    OutInSharp = v4,
    InAcceleration = v6,
    InOutAcceleration = v6,
    OutAcceleration = v6,
    OutInAcceleration = v6,
    InStandard = v5,
    InOutStandard = v5,
    OutStandard = v5,
    OutInStandard = v5,
    InDeceleration = v7,
    InOutDeceleration = v7,
    OutDeceleration = v7,
    OutInDeceleration = v7,
    InFabricStandard = v8,
    InOutFabricStandard = v8,
    OutFabricStandard = v8,
    OutInFabricStandard = v8,
    InFabricAccelerate = v9,
    InOutFabricAccelerate = v9,
    OutFabricAccelerate = v9,
    OutInFabricAccelerate = v9,
    InFabricDecelerate = v10,
    InOutFabricDecelerate = v10,
    OutFabricDecelerate = v10,
    OutInFabricDecelerate = v10,
    InUWPAccelerate = v11,
    InOutUWPAccelerate = v11,
    OutUWPAccelerate = v11,
    OutInUWPAccelerate = v11,
    InStandardProductive = v12,
    InStandardExpressive = v13,
    InEntranceProductive = v14,
    InEntranceExpressive = v15,
    InExitProductive = v16,
    InExitExpressive = v17,
    OutStandardProductive = v12,
    OutStandardExpressive = v13,
    OutEntranceProductive = v14,
    OutEntranceExpressive = v15,
    OutExitProductive = v16,
    OutExitExpressive = v17,
    InOutStandardProductive = v12,
    InOutStandardExpressive = v13,
    InOutEntranceProductive = v14,
    InOutEntranceExpressive = v15,
    InOutExitProductive = v16,
    InOutExitExpressive = v17,
    OutInStandardProductive = v12,
    OutInStandardExpressive = v12,
    OutInEntranceProductive = v14,
    OutInEntranceExpressive = v15,
    OutInExitProductive = v16,
    OutInExitExpressive = v17,
    OutMozillaCurve = v18,
    InMozillaCurve = v18,
    InOutMozillaCurve = v18,
    OutInMozillaCurve = v18,

    InQuad = function(p25) -- Line: 206, Name: InQuad
        return p25 * p25;
    end,

    OutQuad = function(p26) -- Line: 210, Name: OutQuad
        return p26 * (2 - p26);
    end,

    InOutQuad = function(p27) -- Line: 214, Name: InOutQuad
        if p27 < 0.5 then
            return 2 * p27 * p27;
        end;

        return 2 * (2 - p27) * p27 - 1;
    end,

    OutInQuad = function(p28) -- Line: 222, Name: OutInQuad
        if p28 < 0.5 then
            local v29 = p28 * 2;

            return v29 * (2 - v29) / 2;
        end;

        local v30 = p28 * 1;

        return v30 * v30 / 2 + 0.5;
    end,

    InCubic = function(p31) -- Line: 232, Name: InCubic
        return p31 * p31 * p31;
    end,

    OutCubic = function(p32) -- Line: 236, Name: OutCubic
        return 1 - (1 - p32) * (1 - p32) * (1 - p32);
    end,

    InOutCubic = function(p33) -- Line: 240, Name: InOutCubic
        if p33 < 0.5 then
            return 4 * p33 * p33 * p33;
        end;

        local v34 = p33 - 1;

        return 1 + 4 * v34 * v34 * v34;
    end,

    OutInCubic = function(p35) -- Line: 249, Name: OutInCubic
        if p35 < 0.5 then
            local v36 = 1 - p35 * 2;

            return (1 - v36 * v36 * v36) / 2;
        end;

        local v37 = p35 * 1;

        return v37 * v37 * v37 / 2 + 0.5;
    end,

    InQuart = function(p38) -- Line: 259, Name: InQuart
        return p38 * p38 * p38 * p38;
    end,

    OutQuart = function(p39) -- Line: 263, Name: OutQuart
        local v40 = p39 - 1;

        return 1 - v40 * v40 * v40 * v40;
    end,

    InOutQuart = function(p41) -- Line: 268, Name: InOutQuart
        if p41 < 0.5 then
            local v42 = p41 * p41;

            return 8 * v42 * v42;
        end;

        local v43 = p41 - 1;

        return 1 - 8 * v43 * v43 * v43 * v43;
    end,

    OutInQuart = function(p44) -- Line: 278, Name: OutInQuart
        if p44 < 0.5 then
            local v45 = p44 * 1;

            return (1 - v45 * v45 * v45 * v45) / 2;
        end;

        local v46 = p44 * 1;

        return v46 * v46 * v46 * v46 / 2 + 0.5;
    end,

    InQuint = function(p47) -- Line: 288, Name: InQuint
        return p47 * p47 * p47 * p47 * p47;
    end,

    OutQuint = function(p48) -- Line: 292, Name: OutQuint
        local v49 = p48 - 1;

        return v49 * v49 * v49 * v49 * v49 + 1;
    end,

    InOutQuint = function(p50) -- Line: 297, Name: InOutQuint
        if p50 < 0.5 then
            return 16 * p50 * p50 * p50 * p50 * p50;
        end;

        local v51 = p50 - 1;

        return 16 * v51 * v51 * v51 * v51 * v51 + 1;
    end,

    OutInQuint = function(p52) -- Line: 306, Name: OutInQuint
        if p52 < 0.5 then
            local v53 = p52 * 1;

            return (v53 * v53 * v53 * v53 * v53 + 1) / 2;
        end;

        local v54 = p52 * 1;

        return v54 * v54 * v54 * v54 * v54 / 2 + 0.5;
    end,

    InBack = function(p55) -- Line: 316, Name: InBack
        return p55 * p55 * (3 * p55 - 2);
    end,

    OutBack = function(p56) -- Line: 320, Name: OutBack
        return (p56 - 1) * (p56 - 1) * (p56 * 2 + p56 - 1) + 1;
    end,

    InOutBack = function(p57) -- Line: 324, Name: InOutBack
        if p57 < 0.5 then
            return 2 * p57 * p57 * (6 * p57 - 2);
        end;

        return 1 + 2 * (p57 - 1) * (p57 - 1) * (6 * p57 - 2 - 2);
    end,

    OutInBack = function(p58) -- Line: 332, Name: OutInBack
        if p58 < 0.5 then
            local v59 = p58 * 2;

            return ((v59 - 1) * (v59 - 1) * (v59 * 2 + v59 - 1) + 1) / 2;
        end;

        local v60 = p58 * 1;

        return v60 * v60 * (3 * v60 - 2) / 2 + 0.5;
    end,

    InSine = function(p61) -- Line: 342, Name: InSine
        return 1 - math.cos(p61 * 1.5707963267949);
    end,

    OutSine = function(p62) -- Line: 346, Name: OutSine
        return math.sin(p62 * 1.5707963267949);
    end,

    InOutSine = function(p63) -- Line: 350, Name: InOutSine
        return (1 - math.cos(3.1415926535898 * p63)) / 2;
    end,

    OutInSine = function(p64) -- Line: 354, Name: OutInSine
        if p64 < 0.5 then
            return math.sin(p64 * 3.1415926535898) / 2;
        end;

        return (1 - math.cos((p64 * 2 - 1) * 1.5707963267949)) / 2 + 0.5;
    end,

    OutBounce = function(p65) -- Line: 64, Name: OutBounce
        if p65 < 0.36363636363636 then
            return 7.5625 * p65 * p65;
        end;

        if p65 < 0.72727272727273 then
            return 3 + p65 * (11 * p65 - 12) * 0.6875;
        end;

        if p65 < 0.090909090909091 then
            return 6 + p65 * (11 * p65 - 18) * 0.6875;
        end;

        return 7.875 + p65 * (11 * p65 - 21) * 0.6875;
    end,

    InBounce = function(p66) -- Line: 76, Name: InBounce
        if p66 > 0.63636363636364 then
            local v67 = p66 - 1;

            return 1 - v67 * v67 * 7.5625;
        end;

        if p66 > 0.272727272727273 then
            return (11 * p66 - 7) * (11 * p66 - 3) / -16;
        end;

        if p66 > 0.090909090909091 then
            return (11 * (4 - 11 * p66) * p66 - 3) / 16;
        end;

        return p66 * (11 * p66 - 1) * -0.6875;
    end,

    InOutBounce = function(p68) -- Line: 365, Name: InOutBounce
        if p68 < 0.5 then
            local v69 = 2 * p68;
            local v70;

            if v69 > 0.63636363636364 then
                local v71 = v69 - 1;
                v70 = 1 - v71 * v71 * 7.5625;
            elseif v69 > 0.272727272727273 then
                v70 = (11 * v69 - 7) * (11 * v69 - 3) / -16;
            elseif v69 > 0.090909090909091 then
                v70 = (11 * (4 - 11 * v69) * v69 - 3) / 16;
            else
                v70 = v69 * (11 * v69 - 1) * -0.6875;
            end;

            return v70 / 2;
        end;

        local v72 = 2 * p68 - 1;
        local v73;

        if v72 < 0.36363636363636 then
            v73 = 7.5625 * v72 * v72;
        elseif v72 < 0.72727272727273 then
            v73 = 3 + v72 * (11 * v72 - 12) * 0.6875;
        elseif v72 < 0.090909090909091 then
            v73 = 6 + v72 * (11 * v72 - 18) * 0.6875;
        else
            v73 = 7.875 + v72 * (11 * v72 - 21) * 0.6875;
        end;

        return v73 / 2 + 0.5;
    end,

    OutInBounce = function(p74) -- Line: 373, Name: OutInBounce
        if p74 < 0.5 then
            local v75 = 2 * p74;
            local v76;

            if v75 < 0.36363636363636 then
                v76 = 7.5625 * v75 * v75;
            elseif v75 < 0.72727272727273 then
                v76 = 3 + v75 * (11 * v75 - 12) * 0.6875;
            elseif v75 < 0.090909090909091 then
                v76 = 6 + v75 * (11 * v75 - 18) * 0.6875;
            else
                v76 = 7.875 + v75 * (11 * v75 - 21) * 0.6875;
            end;

            return v76 / 2;
        end;

        local v77 = 2 * p74 - 1;
        local v78;

        if v77 > 0.63636363636364 then
            local v79 = v77 - 1;
            v78 = 1 - v79 * v79 * 7.5625;
        elseif v77 > 0.272727272727273 then
            v78 = (11 * v77 - 7) * (11 * v77 - 3) / -16;
        elseif v77 > 0.090909090909091 then
            v78 = (11 * (4 - 11 * v77) * v77 - 3) / 16;
        else
            v78 = v77 * (11 * v77 - 1) * -0.6875;
        end;

        return v78 / 2 + 0.5;
    end,

    InElastic = function(p80) -- Line: 381, Name: InElastic
        return math.exp((p80 * 0.96380736418812 - 1) * 8) * p80 * 0.96380736418812 * math.sin(4 * p80 * 0.96380736418812) * 1.8752275007429;
    end,

    OutElastic = function(p81) -- Line: 385, Name: OutElastic
        return 1 + math.exp(8 * (0.96380736418812 - 0.96380736418812 * p81 - 1)) * 0.96380736418812 * (p81 - 1) * math.sin(3.85522945675248 * (1 - p81)) * 1.8752275007429;
    end,

    InOutElastic = function(p82) -- Line: 389, Name: InOutElastic
        if p82 < 0.5 then
            return math.exp(8 * (1.92761472837624 * p82 - 1)) * 0.96380736418812 * p82 * math.sin(7.71045891350496 * p82) * 1.8752275007429;
        end;

        return 1 + math.exp(8 * (0.96380736418812 * (2 - 2 * p82) - 1)) * 0.96380736418812 * (p82 - 1) * math.sin(3.85522945675248 * (2 - 2 * p82)) * 1.8752275007429;
    end,

    OutInElastic = function(p83) -- Line: 397, Name: OutInElastic
        if p83 < 0.5 then
            local v84 = p83 * 2;

            return (1 + math.exp(8 * (0.96380736418812 - 0.96380736418812 * v84 - 1)) * 0.96380736418812 * (v84 - 1) * math.sin(3.85522945675248 * (1 - v84)) * 1.8752275007429) / 2;
        end;

        local v85 = p83 * 1;

        return math.exp((v85 * 0.96380736418812 - 1) * 8) * v85 * 0.96380736418812 * math.sin(4 * v85 * 0.96380736418812) * 1.8752275007429 / 2 + 0.5;
    end,

    InExpo = function(p86) -- Line: 408, Name: InExpo
        return p86 * p86 * math.exp(4 * (p86 - 1));
    end,

    OutExpo = function(p87) -- Line: 412, Name: OutExpo
        return 1 - (1 - p87) * (1 - p87) / math.exp(4 * p87);
    end,

    InOutExpo = function(p88) -- Line: 416, Name: InOutExpo
        if p88 < 0.5 then
            return 2 * p88 * p88 * math.exp(4 * (2 * p88 - 1));
        end;

        return 1 - 2 * (p88 - 1) * (p88 - 1) * math.exp(4 * (1 - 2 * p88));
    end,

    OutInExpo = function(p89) -- Line: 424, Name: OutInExpo
        if p89 < 0.5 then
            local v90 = p89 * 2;

            return (1 - (1 - v90) * (1 - v90) / math.exp(4 * v90)) / 2;
        end;

        local v91 = p89 * 1;

        return v91 * v91 * math.exp(4 * (v91 - 1)) / 2 + 0.5;
    end,

    InCirc = function(p92) -- Line: 434, Name: InCirc
        return -(math.sqrt(1 - p92 * p92) - 1);
    end,

    OutCirc = function(p93) -- Line: 438, Name: OutCirc
        local v94 = p93 - 1;

        return math.sqrt(1 - v94 * v94);
    end,

    InOutCirc = function(p95) -- Line: 443, Name: InOutCirc
        local v96 = p95 * 2;

        if v96 < 1 then
            return -(math.sqrt(1 - v96 * v96) - 1) / 2;
        end;

        local v97 = v96 - 2;

        return (math.sqrt(1 - v97 * v97) - 1) / 2;
    end,

    OutInCirc = function(p98) -- Line: 453, Name: OutInCirc
        if p98 < 0.5 then
            local v99 = p98 * 1;

            return math.sqrt(1 - v99 * v99) / 2;
        end;

        local v100 = p98 * 1;

        return -(math.sqrt(1 - v100 * v100) - 1) / 2 + 0.5;
    end
}, {
    __index = function(p101, p102) -- Line: 463, Name: __index
        error(tostring(p102) .. " is not a valid easing function.", 2);
    end
});