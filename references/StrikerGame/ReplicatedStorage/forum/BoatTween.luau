 

-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=4939498795

-- ! Source from the asset above; the game may have edited it since.

--[===[
--[==[
	BoatTween (because TweenService2 was taken)
	by boatbomber (Zack Ovits)
	© 2020
	API:
	function BoatTween:Create(Object,Data)
		returns a Tween object
		Params:
		- Object
		The instance that is having it's properties tweened
		- Data
		A dictionary of the various settings of the tween
		{
			number Time = Any positive number
				How long the tween should take to complete
			string EasingStyle = Any TweenStyle from the list below
				The style that the tween follows
				(Note: Uses strings instead of Enum.EasingStyle to allow us to add styles that Roblox doesn't support)
				List of available styles:
					Linear				Quad					Cubic
					Quart				Quint					Sine
					Expo				Circ					Elastic
					Back				Bounce					Smooth
					Smoother			RidiculousWiggle		RevBack
					Spring				SoftSpring				Standard
					Sharp				Acceleration			Deceleration
					StandardProductive	EntranceProductive		ExitProductive
					StandardExpressive	EntranceExpressive		ExitExpressive
					FabricStandard		FabricAccelerate		FabricDecelerate
					UWPAccelerate		MozillaCurve
			string EasingDirection = "In" or "Out" or "InOut" or "OutIn"
				The direction for the TweenStyle to adhere to
			number DelayTime = 0 -> math.huge
				The amount of time before the tween begins playback after calling :Play() on the tween
				(Note: doesn't affect :Resume() calls)
			number RepeatCount = -1 -> math.huge
				How many times the tween should repeat with -1 being infinity
				(Note: will wait the DelayTime in between replaying)
			boolean Reverses = false or true
				Whether the tween should reverse itself after completion
				(note: Waits the DelayTime before reversing)
			table Goal = dictionary
				A dictionary where the keys are properties to tween and the values are the end goals of said properties
				You may tween any property with value of the following types:
					number				boolean					CFrame
					Color3				UDim2					UDim
					Ray					NumberRange				NumberSequenceKeypoint
					PhysicalProperties	NumberSequence			Region3
					Rect				Vector2					Vector3
			string StepType = "Stepped" or "Heartbeat" or "RenderStepped"
				The event of RunService for the tween to move on
		}
	function Tween:Play()
		Plays the tween, starting from the beginning
	function Tween:Stop()
		Stops the tween, freezing it in its current state
	function Tween:Resume()
		Plays the tween, starting from current position and time
	function TweenObject:Destroy()
		Clears connections, stops playback, destroys objects
	property Tween.Instance
		The object being tweened
	property Tween.PlaybackState
		An Enum.PlaybackState representing the Tween's current state
	event Tween.Stopped
		Fired when a Tween ends from the :Stop() function
	event Tween.Completed
		Fired when a Tween ends due to :Play() being completed
	event Tween.Resumed
		Fired when a Tween is played through the :Resume() function
--]==]

local RunService = game:GetService("RunService")
local RawTweenFunctions = require(script.TweenFunctions)
local TypeLerpers = require(script.Lerps)
local Heartbeat = RunService.Heartbeat

local BoatTween = {}

local ValidStepTypes = {
	["Heartbeat"] = true;
	["Stepped"] = true;
	["RenderStepped"] = true;
}

if not RunService:IsClient() then
	ValidStepTypes.RenderStepped = nil
end

local TweenFunctions = {
	FabricAccelerate = {
		In = RawTweenFunctions.InFabricAccelerate;
		Out = RawTweenFunctions.OutFabricAccelerate;
		InOut = RawTweenFunctions.InOutFabricAccelerate;
		OutIn = RawTweenFunctions.OutInFabricAccelerate;
	};

	UWPAccelerate = {
		In = RawTweenFunctions.InUWPAccelerate;
		Out = RawTweenFunctions.OutUWPAccelerate;
		InOut = RawTweenFunctions.InOutUWPAccelerate;
		OutIn = RawTweenFunctions.OutInUWPAccelerate;
	};

	Circ = {
		In = RawTweenFunctions.InCirc;
		Out = RawTweenFunctions.OutCirc;
		InOut = RawTweenFunctions.InOutCirc;
		OutIn = RawTweenFunctions.OutInCirc;
	};

	RevBack = {
		In = RawTweenFunctions.InRevBack;
		Out = RawTweenFunctions.OutRevBack;
		InOut = RawTweenFunctions.InOutRevBack;
		OutIn = RawTweenFunctions.OutInRevBack;
	};

	Spring = {
		In = RawTweenFunctions.InSpring;
		Out = RawTweenFunctions.OutSpring;
		InOut = RawTweenFunctions.InOutSpring;
		OutIn = RawTweenFunctions.OutInSpring;
	};

	Standard = {
		In = RawTweenFunctions.InStandard;
		Out = RawTweenFunctions.OutStandard;
		InOut = RawTweenFunctions.InOutStandard;
		OutIn = RawTweenFunctions.OutInStandard;
	};

	StandardExpressive = {
		In = RawTweenFunctions.InStandardExpressive;
		Out = RawTweenFunctions.OutStandardExpressive;
		InOut = RawTweenFunctions.InOutStandardExpressive;
		OutIn = RawTweenFunctions.OutInStandardExpressive;
	};

	Linear = {
		In = RawTweenFunctions.InLinear;
		Out = RawTweenFunctions.OutLinear;
		InOut = RawTweenFunctions.InOutLinear;
		OutIn = RawTweenFunctions.OutInLinear;
	};

	ExitProductive = {
		In = RawTweenFunctions.InExitProductive;
		Out = RawTweenFunctions.OutExitProductive;
		InOut = RawTweenFunctions.InOutExitProductive;
		OutIn = RawTweenFunctions.OutInExitProductive;
	};

	Deceleration = {
		In = RawTweenFunctions.InDeceleration;
		Out = RawTweenFunctions.OutDeceleration;
		InOut = RawTweenFunctions.InOutDeceleration;
		OutIn = RawTweenFunctions.OutInDeceleration;
	};

	Smoother = {
		In = RawTweenFunctions.InSmoother;
		Out = RawTweenFunctions.OutSmoother;
		InOut = RawTweenFunctions.InOutSmoother;
		OutIn = RawTweenFunctions.OutInSmoother;
	};

	FabricStandard = {
		In = RawTweenFunctions.InFabricStandard;
		Out = RawTweenFunctions.OutFabricStandard;
		InOut = RawTweenFunctions.InOutFabricStandard;
		OutIn = RawTweenFunctions.OutInFabricStandard;
	};

	RidiculousWiggle = {
		In = RawTweenFunctions.InRidiculousWiggle;
		Out = RawTweenFunctions.OutRidiculousWiggle;
		InOut = RawTweenFunctions.InOutRidiculousWiggle;
		OutIn = RawTweenFunctions.OutInRidiculousWiggle;
	};

	MozillaCurve = {
		In = RawTweenFunctions.InMozillaCurve;
		Out = RawTweenFunctions.OutMozillaCurve;
		InOut = RawTweenFunctions.InOutMozillaCurve;
		OutIn = RawTweenFunctions.OutInMozillaCurve;
	};

	Expo = {
		In = RawTweenFunctions.InExpo;
		Out = RawTweenFunctions.OutExpo;
		InOut = RawTweenFunctions.InOutExpo;
		OutIn = RawTweenFunctions.OutInExpo;
	};

	Sine = {
		In = RawTweenFunctions.InSine;
		Out = RawTweenFunctions.OutSine;
		InOut = RawTweenFunctions.InOutSine;
		OutIn = RawTweenFunctions.OutInSine;
	};

	Cubic = {
		In = RawTweenFunctions.InCubic;
		Out = RawTweenFunctions.OutCubic;
		InOut = RawTweenFunctions.InOutCubic;
		OutIn = RawTweenFunctions.OutInCubic;
	};

	EntranceExpressive = {
		In = RawTweenFunctions.InEntranceExpressive;
		Out = RawTweenFunctions.OutEntranceExpressive;
		InOut = RawTweenFunctions.InOutEntranceExpressive;
		OutIn = RawTweenFunctions.OutInEntranceExpressive;
	};

	Elastic = {
		In = RawTweenFunctions.InElastic;
		Out = RawTweenFunctions.OutElastic;
		InOut = RawTweenFunctions.InOutElastic;
		OutIn = RawTweenFunctions.OutInElastic;
	};

	Quint = {
		In = RawTweenFunctions.InQuint;
		Out = RawTweenFunctions.OutQuint;
		InOut = RawTweenFunctions.InOutQuint;
		OutIn = RawTweenFunctions.OutInQuint;
	};

	EntranceProductive = {
		In = RawTweenFunctions.InEntranceProductive;
		Out = RawTweenFunctions.OutEntranceProductive;
		InOut = RawTweenFunctions.InOutEntranceProductive;
		OutIn = RawTweenFunctions.OutInEntranceProductive;
	};

	Bounce = {
		In = RawTweenFunctions.InBounce;
		Out = RawTweenFunctions.OutBounce;
		InOut = RawTweenFunctions.InOutBounce;
		OutIn = RawTweenFunctions.OutInBounce;
	};

	Smooth = {
		In = RawTweenFunctions.InSmooth;
		Out = RawTweenFunctions.OutSmooth;
		InOut = RawTweenFunctions.InOutSmooth;
		OutIn = RawTweenFunctions.OutInSmooth;
	};

	Back = {
		In = RawTweenFunctions.InBack;
		Out = RawTweenFunctions.OutBack;
		InOut = RawTweenFunctions.InOutBack;
		OutIn = RawTweenFunctions.OutInBack;
	};

	Quart = {
		In = RawTweenFunctions.InQuart;
		Out = RawTweenFunctions.OutQuart;
		InOut = RawTweenFunctions.InOutQuart;
		OutIn = RawTweenFunctions.OutInQuart;
	};

	StandardProductive = {
		In = RawTweenFunctions.InStandardProductive;
		Out = RawTweenFunctions.OutStandardProductive;
		InOut = RawTweenFunctions.InOutStandardProductive;
		OutIn = RawTweenFunctions.OutInStandardProductive;
	};

	Quad = {
		In = RawTweenFunctions.InQuad;
		Out = RawTweenFunctions.OutQuad;
		InOut = RawTweenFunctions.InOutQuad;
		OutIn = RawTweenFunctions.OutInQuad;
	};

	FabricDecelerate = {
		In = RawTweenFunctions.InFabricDecelerate;
		Out = RawTweenFunctions.OutFabricDecelerate;
		InOut = RawTweenFunctions.InOutFabricDecelerate;
		OutIn = RawTweenFunctions.OutInFabricDecelerate;
	};

	Acceleration = {
		In = RawTweenFunctions.InAcceleration;
		Out = RawTweenFunctions.OutAcceleration;
		InOut = RawTweenFunctions.InOutAcceleration;
		OutIn = RawTweenFunctions.OutInAcceleration;
	};

	SoftSpring = {
		In = RawTweenFunctions.InSoftSpring;
		Out = RawTweenFunctions.OutSoftSpring;
		InOut = RawTweenFunctions.InOutSoftSpring;
		OutIn = RawTweenFunctions.OutInSoftSpring;
	};

	ExitExpressive = {
		In = RawTweenFunctions.InExitExpressive;
		Out = RawTweenFunctions.OutExitExpressive;
		InOut = RawTweenFunctions.InOutExitExpressive;
		OutIn = RawTweenFunctions.OutInExitExpressive;
	};

	Sharp = {
		In = RawTweenFunctions.InSharp;
		Out = RawTweenFunctions.OutSharp;
		InOut = RawTweenFunctions.InOutSharp;
		OutIn = RawTweenFunctions.OutInSharp;
	};
}

local function Wait(Seconds)
	Seconds = math.max(Seconds or 0.03, 0)
	local TimeRemaining = Seconds

	while TimeRemaining > 0 do
		TimeRemaining -= Heartbeat:Wait()
	end

	return Seconds - TimeRemaining
end

function BoatTween.Create(_, Object, Data)
	-- Validate
	if not Object or typeof(Object) ~= "Instance" then
		return warn("Invalid object to tween:", Object)
	end

	Data = type(Data) == "table" and Data or {}

	-- Define settings
	local EventStep: RBXScriptSignal = ValidStepTypes[Data.StepType] and RunService[Data.StepType] or RunService.Stepped
	local TweenFunction = TweenFunctions[Data.EasingStyle or "Quad"][Data.EasingDirection or "In"]
	local Time = math.max(type(Data.Time) == "number" and Data.Time or 1, 0.001)
	local Goal = type(Data.Goal) == "table" and Data.Goal or {}
	local DelayTime = type(Data.DelayTime) == "number" and Data.DelayTime > 0.027 and Data.DelayTime
	local RepeatCount = (type(Data.RepeatCount) == "number" and math.max(Data.RepeatCount, -1) or 0) + 1

	local TweenData = {}
	for Property, EndValue in pairs(Goal) do
		TweenData[Property] = TypeLerpers[typeof(EndValue)](Object[Property], EndValue)
	end

	-- Create instances
	local CompletedEvent = Instance.new("BindableEvent")
	local StoppedEvent = Instance.new("BindableEvent")
	local ResumedEvent = Instance.new("BindableEvent")

	local PlaybackConnection
	local StartTime, ElapsedTime = os.clock(), 0

	local TweenObject = {
		["Instance"] = Object;
		["PlaybackState"] = Enum.PlaybackState.Begin;

		["Completed"] = CompletedEvent.Event;
		["Resumed"] = ResumedEvent.Event;
		["Stopped"] = StoppedEvent.Event;
	}

	function TweenObject.Destroy()
		if PlaybackConnection then
			PlaybackConnection:Disconnect()
			PlaybackConnection = nil
		end

		CompletedEvent:Destroy()
		StoppedEvent:Destroy()
		ResumedEvent:Destroy()
		TweenObject = nil
	end

	local CurrentlyReversing = false
	local CurrentLayer = 0

	local function Play(Layer, Reverse)
		if PlaybackConnection then
			PlaybackConnection:Disconnect()
			PlaybackConnection = nil
		end

		Layer = Layer or 1
		if RepeatCount ~= 0 then
			if Layer > RepeatCount then
				TweenObject.PlaybackState = Enum.PlaybackState.Completed
				CompletedEvent:Fire()
				CurrentlyReversing = false
				CurrentLayer = 1
				return
			end
		end

		CurrentLayer = Layer

		if Reverse then
			CurrentlyReversing = true
		end

		if DelayTime then
			TweenObject.PlaybackState = Enum.PlaybackState.Delayed;
			(DelayTime < 2 and Wait or wait)(DelayTime)
		end

		StartTime = os.clock() - ElapsedTime
		PlaybackConnection = EventStep:Connect(function()
			ElapsedTime = os.clock() - StartTime
			if ElapsedTime >= Time then
				if Reverse then
					for Property, Lerper in pairs(TweenData) do
						Object[Property] = Lerper(0)
					end
				else
					for Property, Lerper in pairs(TweenData) do
						Object[Property] = Lerper(1)
					end
				end

				PlaybackConnection:Disconnect()
				PlaybackConnection = nil
				if Reverse then
					ElapsedTime = 0
					Play(Layer + 1, false)
				else
					if Data.Reverses then
						ElapsedTime = 0
						Play(Layer, true)
					else
						ElapsedTime = 0
						Play(Layer + 1, false)
					end
				end
			else
				local Delta = Reverse and (1 - ElapsedTime/Time) or (ElapsedTime/Time)
				local Position = math.clamp(TweenFunction(Delta), 0, 1)

				for Property, Lerper in pairs(TweenData) do
					Object[Property] = Lerper(Position)
				end
			end
		end)

		TweenObject.PlaybackState = Enum.PlaybackState.Playing
	end

	function TweenObject.Play()
		ElapsedTime = 0
		Play(1, false)
	end

	function TweenObject.Stop()
		if PlaybackConnection then
			PlaybackConnection:Disconnect()
			PlaybackConnection = nil
			TweenObject.PlaybackState = Enum.PlaybackState.Cancelled
			StoppedEvent:Fire()
		end
	end

	function TweenObject.Resume()
		Play(CurrentLayer, CurrentlyReversing)
		ResumedEvent:Fire()
	end

	return TweenObject
end

return BoatTween
]===]

 

local RunService = game:GetService("RunService");
local script_TweenFunctions = require(script.TweenFunctions);
local script_Lerps = require(script.Lerps);
local Heartbeat = RunService.Heartbeat;
local v1 = {};
local u2 = {
    Heartbeat = true,
    Stepped = true,
    RenderStepped = true
};

if not RunService:IsClient() then
    u2.RenderStepped = nil;
end;

local u3 = {
    FabricAccelerate = {
        In = script_TweenFunctions.InFabricAccelerate,
        Out = script_TweenFunctions.OutFabricAccelerate,
        InOut = script_TweenFunctions.InOutFabricAccelerate,
        OutIn = script_TweenFunctions.OutInFabricAccelerate
    },
    UWPAccelerate = {
        In = script_TweenFunctions.InUWPAccelerate,
        Out = script_TweenFunctions.OutUWPAccelerate,
        InOut = script_TweenFunctions.InOutUWPAccelerate,
        OutIn = script_TweenFunctions.OutInUWPAccelerate
    },
    Circ = {
        In = script_TweenFunctions.InCirc,
        Out = script_TweenFunctions.OutCirc,
        InOut = script_TweenFunctions.InOutCirc,
        OutIn = script_TweenFunctions.OutInCirc
    },
    RevBack = {
        In = script_TweenFunctions.InRevBack,
        Out = script_TweenFunctions.OutRevBack,
        InOut = script_TweenFunctions.InOutRevBack,
        OutIn = script_TweenFunctions.OutInRevBack
    },
    Spring = {
        In = script_TweenFunctions.InSpring,
        Out = script_TweenFunctions.OutSpring,
        InOut = script_TweenFunctions.InOutSpring,
        OutIn = script_TweenFunctions.OutInSpring
    },
    Standard = {
        In = script_TweenFunctions.InStandard,
        Out = script_TweenFunctions.OutStandard,
        InOut = script_TweenFunctions.InOutStandard,
        OutIn = script_TweenFunctions.OutInStandard
    },
    StandardExpressive = {
        In = script_TweenFunctions.InStandardExpressive,
        Out = script_TweenFunctions.OutStandardExpressive,
        InOut = script_TweenFunctions.InOutStandardExpressive,
        OutIn = script_TweenFunctions.OutInStandardExpressive
    },
    Linear = {
        In = script_TweenFunctions.InLinear,
        Out = script_TweenFunctions.OutLinear,
        InOut = script_TweenFunctions.InOutLinear,
        OutIn = script_TweenFunctions.OutInLinear
    },
    ExitProductive = {
        In = script_TweenFunctions.InExitProductive,
        Out = script_TweenFunctions.OutExitProductive,
        InOut = script_TweenFunctions.InOutExitProductive,
        OutIn = script_TweenFunctions.OutInExitProductive
    },
    Deceleration = {
        In = script_TweenFunctions.InDeceleration,
        Out = script_TweenFunctions.OutDeceleration,
        InOut = script_TweenFunctions.InOutDeceleration,
        OutIn = script_TweenFunctions.OutInDeceleration
    },
    Smoother = {
        In = script_TweenFunctions.InSmoother,
        Out = script_TweenFunctions.OutSmoother,
        InOut = script_TweenFunctions.InOutSmoother,
        OutIn = script_TweenFunctions.OutInSmoother
    },
    FabricStandard = {
        In = script_TweenFunctions.InFabricStandard,
        Out = script_TweenFunctions.OutFabricStandard,
        InOut = script_TweenFunctions.InOutFabricStandard,
        OutIn = script_TweenFunctions.OutInFabricStandard
    },
    RidiculousWiggle = {
        In = script_TweenFunctions.InRidiculousWiggle,
        Out = script_TweenFunctions.OutRidiculousWiggle,
        InOut = script_TweenFunctions.InOutRidiculousWiggle,
        OutIn = script_TweenFunctions.OutInRidiculousWiggle
    },
    MozillaCurve = {
        In = script_TweenFunctions.InMozillaCurve,
        Out = script_TweenFunctions.OutMozillaCurve,
        InOut = script_TweenFunctions.InOutMozillaCurve,
        OutIn = script_TweenFunctions.OutInMozillaCurve
    },
    Expo = {
        In = script_TweenFunctions.InExpo,
        Out = script_TweenFunctions.OutExpo,
        InOut = script_TweenFunctions.InOutExpo,
        OutIn = script_TweenFunctions.OutInExpo
    },
    Sine = {
        In = script_TweenFunctions.InSine,
        Out = script_TweenFunctions.OutSine,
        InOut = script_TweenFunctions.InOutSine,
        OutIn = script_TweenFunctions.OutInSine
    },
    Cubic = {
        In = script_TweenFunctions.InCubic,
        Out = script_TweenFunctions.OutCubic,
        InOut = script_TweenFunctions.InOutCubic,
        OutIn = script_TweenFunctions.OutInCubic
    },
    EntranceExpressive = {
        In = script_TweenFunctions.InEntranceExpressive,
        Out = script_TweenFunctions.OutEntranceExpressive,
        InOut = script_TweenFunctions.InOutEntranceExpressive,
        OutIn = script_TweenFunctions.OutInEntranceExpressive
    },
    Elastic = {
        In = script_TweenFunctions.InElastic,
        Out = script_TweenFunctions.OutElastic,
        InOut = script_TweenFunctions.InOutElastic,
        OutIn = script_TweenFunctions.OutInElastic
    },
    Quint = {
        In = script_TweenFunctions.InQuint,
        Out = script_TweenFunctions.OutQuint,
        InOut = script_TweenFunctions.InOutQuint,
        OutIn = script_TweenFunctions.OutInQuint
    },
    EntranceProductive = {
        In = script_TweenFunctions.InEntranceProductive,
        Out = script_TweenFunctions.OutEntranceProductive,
        InOut = script_TweenFunctions.InOutEntranceProductive,
        OutIn = script_TweenFunctions.OutInEntranceProductive
    },
    Bounce = {
        In = script_TweenFunctions.InBounce,
        Out = script_TweenFunctions.OutBounce,
        InOut = script_TweenFunctions.InOutBounce,
        OutIn = script_TweenFunctions.OutInBounce
    },
    Smooth = {
        In = script_TweenFunctions.InSmooth,
        Out = script_TweenFunctions.OutSmooth,
        InOut = script_TweenFunctions.InOutSmooth,
        OutIn = script_TweenFunctions.OutInSmooth
    },
    Back = {
        In = script_TweenFunctions.InBack,
        Out = script_TweenFunctions.OutBack,
        InOut = script_TweenFunctions.InOutBack,
        OutIn = script_TweenFunctions.OutInBack
    },
    Quart = {
        In = script_TweenFunctions.InQuart,
        Out = script_TweenFunctions.OutQuart,
        InOut = script_TweenFunctions.InOutQuart,
        OutIn = script_TweenFunctions.OutInQuart
    },
    StandardProductive = {
        In = script_TweenFunctions.InStandardProductive,
        Out = script_TweenFunctions.OutStandardProductive,
        InOut = script_TweenFunctions.InOutStandardProductive,
        OutIn = script_TweenFunctions.OutInStandardProductive
    },
    Quad = {
        In = script_TweenFunctions.InQuad,
        Out = script_TweenFunctions.OutQuad,
        InOut = script_TweenFunctions.InOutQuad,
        OutIn = script_TweenFunctions.OutInQuad
    },
    FabricDecelerate = {
        In = script_TweenFunctions.InFabricDecelerate,
        Out = script_TweenFunctions.OutFabricDecelerate,
        InOut = script_TweenFunctions.InOutFabricDecelerate,
        OutIn = script_TweenFunctions.OutInFabricDecelerate
    },
    Acceleration = {
        In = script_TweenFunctions.InAcceleration,
        Out = script_TweenFunctions.OutAcceleration,
        InOut = script_TweenFunctions.InOutAcceleration,
        OutIn = script_TweenFunctions.OutInAcceleration
    },
    SoftSpring = {
        In = script_TweenFunctions.InSoftSpring,
        Out = script_TweenFunctions.OutSoftSpring,
        InOut = script_TweenFunctions.InOutSoftSpring,
        OutIn = script_TweenFunctions.OutInSoftSpring
    },
    ExitExpressive = {
        In = script_TweenFunctions.InExitExpressive,
        Out = script_TweenFunctions.OutExitExpressive,
        InOut = script_TweenFunctions.InOutExitExpressive,
        OutIn = script_TweenFunctions.OutInExitExpressive
    },
    Sharp = {
        In = script_TweenFunctions.InSharp,
        Out = script_TweenFunctions.OutSharp,
        InOut = script_TweenFunctions.InOutSharp,
        OutIn = script_TweenFunctions.OutInSharp
    }
};

local function Wait(p4) -- Line: 316
    -- upvalues: Heartbeat (copy)
    local math_max_ret = math.max(p4 or 0.03, 0);
    local v5 = math_max_ret;

    while math_max_ret > 0 do
        math_max_ret = math_max_ret - Heartbeat:Wait();
    end;

    return v5 - math_max_ret;
end;

function v1.Create(p6, u7, p8) -- Line: 327
    -- upvalues: u2 (copy), RunService (copy), u3 (copy), script_Lerps (copy), Wait (copy)
    if not u7 or typeof(u7) ~= "Instance" then
        return warn("Invalid object to tween:", u7);
    end;

    local u9 = type(p8) == "table" and (p8 or {}) or {};
    local u10 = u2[u9.StepType] and RunService[u9.StepType] or RunService.Stepped;
    local u11 = u3[u9.EasingStyle or "Quad"][u9.EasingDirection or "In"];
    local v12 = type(u9.Time) == "number" and (u9.Time or 1) or 1;
    local math_max_ret = math.max(v12, 0.001);
    local v13 = type(u9.Goal) == "table" and (u9.Goal or {}) or {};
    local u14;

    if type(u9.DelayTime) == "number" and u9.DelayTime > 0.027 then
        u14 = u9.DelayTime;
    else
        u14 = false;
    end;

    local u15 = (type(u9.RepeatCount) == "number" and (math.max(u9.RepeatCount, -1) or 0) or 0) + 1;
    local u16 = {};

    for i, v in pairs(v13) do
        u16[i] = script_Lerps[typeof(v)](u7[i], v);
    end;

    local BindableEvent = Instance.new("BindableEvent");
    local BindableEvent2 = Instance.new("BindableEvent");
    local BindableEvent3 = Instance.new("BindableEvent");
    local u17 = nil;
    local os_clock_ret = os.clock();
    local u18 = 0;
    local u19 = {
        Instance = u7,
        PlaybackState = Enum.PlaybackState.Begin,
        Completed = BindableEvent.Event,
        Resumed = BindableEvent3.Event,
        Stopped = BindableEvent2.Event
    };

    function u19.Destroy() -- Line: 365
        -- upvalues: u17 (ref), BindableEvent (copy), BindableEvent2 (copy), BindableEvent3 (copy), u19 (ref)
        if u17 then
            u17:Disconnect();
            u17 = nil;
        end;

        BindableEvent:Destroy();
        BindableEvent2:Destroy();
        BindableEvent3:Destroy();
        u19 = nil;
    end;

    local u20 = false;
    local u21 = 0;

    local function Play(p22, u23) -- Line: 380
        -- upvalues: u17 (ref), u15 (copy), u19 (ref), BindableEvent (copy), u20 (ref), u21 (ref), u14 (copy), Wait (ref), os_clock_ret (ref), u18 (ref), u10 (copy), math_max_ret (copy), u16 (copy), u7 (copy), Play (copy), u9 (ref), u11 (copy)
        if u17 then
            u17:Disconnect();
            u17 = nil;
        end;

        local u24 = p22 or 1;

        if u15 ~= 0 and u15 < u24 then
            u19.PlaybackState = Enum.PlaybackState.Completed;
            BindableEvent:Fire();
            u20 = false;
            u21 = 1;

            return;
        end;

        u21 = u24;

        if u23 then
            u20 = true;
        end;

        if u14 then
            u19.PlaybackState = Enum.PlaybackState.Delayed;
            (u14 < 2 and Wait or wait)(u14);
        end;

        os_clock_ret = os.clock() - u18;
        u17 = u10:Connect(function() -- Line: 409
            -- upvalues: u18 (ref), os_clock_ret (ref), math_max_ret (ref), u23 (copy), u16 (ref), u7 (ref), u17 (ref), Play (ref), u24 (ref), u9 (ref), u11 (ref)
            u18 = os.clock() - os_clock_ret;

            if math_max_ret > u18 then
                local v25 = u11(u23 and 1 - u18 / math_max_ret or u18 / math_max_ret);
                local math_clamp_ret = math.clamp(v25, 0, 1);

                for i, v in pairs(u16) do
                    u7[i] = v(math_clamp_ret);
                end;

                return;
            end;

            if u23 then
                for i, v in pairs(u16) do
                    u7[i] = v(0);
                end;
            else
                for i, v in pairs(u16) do
                    u7[i] = v(1);
                end;
            end;

            u17:Disconnect();
            u17 = nil;

            if u23 then
                u18 = 0;
                Play(u24 + 1, false);

                return;
            end;

            if u9.Reverses then
                u18 = 0;
                Play(u24, true);

                return;
            end;

            u18 = 0;
            Play(u24 + 1, false);
        end);
        u19.PlaybackState = Enum.PlaybackState.Playing;
    end;

    function u19.Play() -- Line: 449
        -- upvalues: u18 (ref), Play (copy)
        u18 = 0;
        Play(1, false);
    end;

    function u19.Stop() -- Line: 454
        -- upvalues: u17 (ref), u19 (ref), BindableEvent2 (copy)
        if u17 then
            u17:Disconnect();
            u17 = nil;
            u19.PlaybackState = Enum.PlaybackState.Cancelled;
            BindableEvent2:Fire();
        end;
    end;

    function u19.Resume() -- Line: 463
        -- upvalues: Play (copy), u21 (ref), u20 (ref), BindableEvent3 (copy)
        Play(u21, u20);
        BindableEvent3:Fire();
    end;

    return u19;
end;

return v1;