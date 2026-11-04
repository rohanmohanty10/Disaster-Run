 -- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[[
return function()
	local Component = require(script.Parent)

	local CollectionService = game:GetService("CollectionService")
	local RunService = game:GetService("RunService")

	local TAG = "__KnitTestComponent__"

	local taggedInstanceFolder

	local function CreateTaggedInstance()
		local folder = Instance.new("Folder")
		CollectionService:AddTag(folder, TAG)
		folder.Name = "ComponentTest"
		folder.Archivable = false
		folder.Parent = taggedInstanceFolder
		return folder
	end

	local ExtensionTest = {}
	function ExtensionTest.ShouldConstruct(_component)
		return true
	end
	function ExtensionTest.Constructing(component)
		component.Data = "a"
		component.DidHeartbeat = false
		component.DidStepped = false
		component.DidRenderStepped = false
	end
	function ExtensionTest.Constructed(component)
		component.Data ..= "c"
	end
	function ExtensionTest.Starting(component)
		component.Data ..= "d"
	end
	function ExtensionTest.Started(component)
		component.Data ..= "f"
	end
	function ExtensionTest.Stopping(component)
		component.Data ..= "g"
	end
	function ExtensionTest.Stopped(component)
		component.Data ..= "i"
	end

	local TestComponentMain = Component.new({
		Tag = TAG,
		Ancestors = { workspace, game:GetService("Lighting") },
		Extensions = { ExtensionTest },
	})

	local AnotherComponent = Component.new({ Tag = TAG })
	function AnotherComponent:GetData()
		return true
	end

	function TestComponentMain:Construct()
		self.Data ..= "b"
	end

	function TestComponentMain:Start()
		self.Another = self:GetComponent(AnotherComponent)
		self.Data ..= "e"
	end

	function TestComponentMain:Stop()
		self.Data ..= "h"
	end

	function TestComponentMain:HeartbeatUpdate(_dt)
		self.DidHeartbeat = true
	end

	function TestComponentMain:SteppedUpdate(_dt)
		self.DidStepped = true
	end

	function TestComponentMain:RenderSteppedUpdate(_dt)
		self.DidRenderStepped = true
	end

	beforeAll(function()
		taggedInstanceFolder = Instance.new("Folder")
		taggedInstanceFolder.Name = "KnitComponentTest"
		taggedInstanceFolder.Archivable = false
		taggedInstanceFolder.Parent = workspace
	end)

	afterEach(function()
		taggedInstanceFolder:ClearAllChildren()
	end)

	afterAll(function()
		taggedInstanceFolder:Destroy()
		TestComponentMain:Destroy()
	end)

	describe("Component", function()
		it("should capture start and stop events", function()
			local didStart = 0
			local didStop = 0
			local started = TestComponentMain.Started:Connect(function()
				didStart += 1
			end)
			local stopped = TestComponentMain.Stopped:Connect(function()
				didStop += 1
			end)
			local instance = CreateTaggedInstance()
			task.wait()
			instance:Destroy()
			task.wait()
			started:Disconnect()
			stopped:Disconnect()
			expect(didStart).to.equal(1)
			expect(didStop).to.equal(1)
		end)

		it("should be able to get component from the instance", function()
			local instance = CreateTaggedInstance()
			task.wait()
			local component = TestComponentMain:FromInstance(instance)
			expect(component).to.be.ok()
		end)

		it("should be able to get all component instances existing", function()
			local numComponents = 3
			local instances = table.create(numComponents)
			for i = 1, numComponents do
				local instance = CreateTaggedInstance()
				instances[i] = instance
			end
			task.wait()
			local components = TestComponentMain:GetAll()
			expect(components).to.be.a("table")
			expect(#components).to.equal(numComponents)
			for _, c in ipairs(components) do
				expect(table.find(instances, c.Instance)).to.be.ok()
			end
		end)

		it("should call lifecycle methods and extension functions", function()
			local instance = CreateTaggedInstance()
			task.wait(0.2)
			local component = TestComponentMain:FromInstance(instance)
			expect(component).to.be.ok()
			expect(component.Data).to.equal("abcdef")
			expect(component.DidHeartbeat).to.equal(true)
			expect(component.DidStepped).to.equal(RunService:IsRunning())
			expect(component.DidRenderStepped).to.never.equal(true)
			instance:Destroy()
			task.wait()
			expect(component.Data).to.equal("abcdefghi")
		end)

		it("should get another component linked to the same instance", function()
			local instance = CreateTaggedInstance()
			task.wait()
			local component = TestComponentMain:FromInstance(instance)
			expect(component).to.be.ok()
			expect(component.Another).to.be.ok()
			expect(component.Another:GetData()).to.equal(true)
		end)

		it("should use extension to decide whether or not to construct", function()
			local e1 = { c = true }
			function e1.ShouldConstruct(_component)
				return e1.c
			end

			local e2 = { c = true }
			function e2.ShouldConstruct(_component)
				return e2.c
			end

			local e3 = { c = true }
			function e3.ShouldConstruct(_component)
				return e3.c
			end

			local c1 = Component.new({ Tag = TAG, Extensions = { e1 } })
			local c2 = Component.new({ Tag = TAG, Extensions = { e1, e2 } })
			local c3 = Component.new({ Tag = TAG, Extensions = { e1, e2, e3 } })

			local function SetE(a, b, c)
				e1.c = a
				e2.c = b
				e3.c = c
			end

			local function Check(inst, comp, shouldExist)
				local c = comp:FromInstance(inst)
				if shouldExist then
					expect(c).to.be.ok()
				else
					expect(c).to.never.be.ok()
				end
			end

			local function CreateAndCheckAll(a, b, c)
				local instance = CreateTaggedInstance()
				task.wait()
				Check(instance, c1, a)
				Check(instance, c2, b)
				Check(instance, c3, c)
			end

			-- All green:
			SetE(true, true, true)
			CreateAndCheckAll(true, true, true)

			-- All red:
			SetE(false, false, false)
			CreateAndCheckAll(false, false, false)

			-- One red:
			SetE(true, false, true)
			CreateAndCheckAll(true, false, false)

			-- One green:
			SetE(false, false, true)
			CreateAndCheckAll(false, false, false)
		end)

		it("should decide whether or not to use extend", function()
			local e1 = { extend = true }
			function e1.ShouldExtend(_component)
				return e1.extend
			end
			function e1.Constructing(component)
				component.E1 = true
			end

			local e2 = { extend = true }
			function e2.ShouldExtend(_component)
				return e2.extend
			end
			function e2.Constructing(component)
				component.E2 = true
			end

			local TestComponent = Component.new({ Tag = TAG, Extensions = { e1, e2 } })

			local function SetAndCheck(ex1, ex2)
				e1.extend = ex1
				e2.extend = ex2
				local instance = CreateTaggedInstance()
				task.wait()
				local component = TestComponent:FromInstance(instance)
				expect(component).to.be.ok()
				if ex1 then
					expect(component.E1).to.equal(true)
				else
					expect(component.E1).to.never.be.ok()
				end
				if ex2 then
					expect(component.E2).to.equal(true)
				else
					expect(component.E2).to.never.be.ok()
				end
			end

			SetAndCheck(true, true)
			SetAndCheck(false, false)
			SetAndCheck(true, false)
			SetAndCheck(false, true)
		end)

		it("should allow yielding within construct", function()
			local CUSTOM_TAG = "CustomTag"

			local TestComponent = Component.new({ Tag = CUSTOM_TAG })

			local numConstruct = 0

			function TestComponent:Construct()
				numConstruct += 1
				task.wait(0.5)
			end

			local p = Instance.new("Part")
			p.Anchored = true
			p.Parent = game:GetService("ReplicatedStorage")
			CollectionService:AddTag(p, CUSTOM_TAG)
			local newP = p:Clone()
			newP.Parent = workspace

			task.wait(0.6)

			expect(numConstruct).to.equal(1)
			p:Destroy()
			newP:Destroy()
		end)

		it("should wait for instance", function()
			local p = Instance.new("Part")
			p.Anchored = true
			p.Parent = workspace
			task.delay(0.1, function()
				CollectionService:AddTag(p, TAG)
			end)
			local success, c = TestComponentMain:WaitForInstance(p):timeout(1):await()
			expect(success).to.equal(true)
			expect(c).to.be.a("table")
			expect(c.Instance).to.equal(p)
			p:Destroy()
		end)
	end)
end

]]

 

return function() -- Line: 1
    local script_Parent = require(script.Parent);
    local CollectionService = game:GetService("CollectionService");
    local RunService = game:GetService("RunService");
    local u1 = nil;

    local function CreateTaggedInstance() -- Line: 11
        -- upvalues: CollectionService (copy), u1 (ref)
        local Folder = Instance.new("Folder");
        CollectionService:AddTag(Folder, "__KnitTestComponent__");
        Folder.Name = "ComponentTest";
        Folder.Archivable = false;
        Folder.Parent = u1;

        return Folder;
    end;

    local u9 = script_Parent.new({
        Tag = "__KnitTestComponent__",
        Ancestors = { workspace, game:GetService("Lighting") },
        Extensions = {
            {
                ShouldConstruct = function(p2) -- Line: 21, Name: ShouldConstruct
                    return true;
                end,

                Constructing = function(p3) -- Line: 24, Name: Constructing
                    p3.Data = "a";
                    p3.DidHeartbeat = false;
                    p3.DidStepped = false;
                    p3.DidRenderStepped = false;
                end,

                Constructed = function(p4) -- Line: 30, Name: Constructed
                    p4.Data = p4.Data .. "c";
                end,

                Starting = function(p5) -- Line: 33, Name: Starting
                    p5.Data = p5.Data .. "d";
                end,

                Started = function(p6) -- Line: 36, Name: Started
                    p6.Data = p6.Data .. "f";
                end,

                Stopping = function(p7) -- Line: 39, Name: Stopping
                    p7.Data = p7.Data .. "g";
                end,

                Stopped = function(p8) -- Line: 42, Name: Stopped
                    p8.Data = p8.Data .. "i";
                end
            }
        }
    });
    local u10 = script_Parent.new({
        Tag = "__KnitTestComponent__"
    });

    function u10.GetData(p11) -- Line: 53
        return true;
    end;

    function u9.Construct(p12) -- Line: 57
        p12.Data = p12.Data .. "b";
    end;

    function u9.Start(p13) -- Line: 61
        -- upvalues: u10 (copy)
        p13.Another = p13:GetComponent(u10);
        p13.Data = p13.Data .. "e";
    end;

    function u9.Stop(p14) -- Line: 66
        p14.Data = p14.Data .. "h";
    end;

    function u9.HeartbeatUpdate(p15, p16) -- Line: 70
        p15.DidHeartbeat = true;
    end;

    function u9.SteppedUpdate(p17, p18) -- Line: 74
        p17.DidStepped = true;
    end;

    function u9.RenderSteppedUpdate(p19, p20) -- Line: 78
        p19.DidRenderStepped = true;
    end;

    beforeAll(function() -- Line: 82
        -- upvalues: u1 (ref)
        u1 = Instance.new("Folder");
        u1.Name = "KnitComponentTest";
        u1.Archivable = false;
        u1.Parent = workspace;
    end);
    afterEach(function() -- Line: 89
        -- upvalues: u1 (ref)
        u1:ClearAllChildren();
    end);
    afterAll(function() -- Line: 93
        -- upvalues: u1 (ref), u9 (copy)
        u1:Destroy();
        u9:Destroy();
    end);
    describe("Component", function() -- Line: 98
        -- upvalues: u9 (copy), CollectionService (copy), u1 (ref), RunService (copy), script_Parent (copy)
        it("should capture start and stop events", function() -- Line: 99
            -- upvalues: u9 (ref), CollectionService (ref), u1 (ref)
            local u21 = 0;
            local u22 = 0;
            local v23 = u9.Started:Connect(function() -- Line: 102
                -- upvalues: u21 (ref)
                u21 = u21 + 1;
            end);
            local v24 = u9.Stopped:Connect(function() -- Line: 105
                -- upvalues: u22 (ref)
                u22 = u22 + 1;
            end);
            local Folder = Instance.new("Folder");
            CollectionService:AddTag(Folder, "__KnitTestComponent__");
            Folder.Name = "ComponentTest";
            Folder.Archivable = false;
            Folder.Parent = u1;
            task.wait();
            Folder:Destroy();
            task.wait();
            v23:Disconnect();
            v24:Disconnect();
            expect(u21).to.equal(1);
            expect(u22).to.equal(1);
        end);
        it("should be able to get component from the instance", function() -- Line: 118
            -- upvalues: CollectionService (ref), u1 (ref), u9 (ref)
            local Folder = Instance.new("Folder");
            CollectionService:AddTag(Folder, "__KnitTestComponent__");
            Folder.Name = "ComponentTest";
            Folder.Archivable = false;
            Folder.Parent = u1;
            task.wait();
            local v25 = u9:FromInstance(Folder);
            expect(v25).to.be.ok();
        end);
        it("should be able to get all component instances existing", function() -- Line: 125
            -- upvalues: CollectionService (ref), u1 (ref), u9 (ref)
            local table_create_ret = table.create(3);
            local Folder = Instance.new("Folder");
            CollectionService:AddTag(Folder, "__KnitTestComponent__");
            Folder.Name = "ComponentTest";
            Folder.Archivable = false;
            Folder.Parent = u1;
            table_create_ret[1] = Folder;
            local Folder2 = Instance.new("Folder");
            CollectionService:AddTag(Folder2, "__KnitTestComponent__");
            Folder2.Name = "ComponentTest";
            Folder2.Archivable = false;
            Folder2.Parent = u1;
            table_create_ret[2] = Folder2;
            local Folder3 = Instance.new("Folder");
            CollectionService:AddTag(Folder3, "__KnitTestComponent__");
            Folder3.Name = "ComponentTest";
            Folder3.Archivable = false;
            Folder3.Parent = u1;
            table_create_ret[3] = Folder3;
            task.wait();
            local All = u9:GetAll();
            expect(All).to.be.a("table");
            expect(#All).to.equal(3);

            for _, v in ipairs(All) do
                expect(table.find(table_create_ret, v.Instance)).to.be.ok();
            end;
        end);
        it("should call lifecycle methods and extension functions", function() -- Line: 141
            -- upvalues: CollectionService (ref), u1 (ref), u9 (ref), RunService (ref)
            local Folder = Instance.new("Folder");
            CollectionService:AddTag(Folder, "__KnitTestComponent__");
            Folder.Name = "ComponentTest";
            Folder.Archivable = false;
            Folder.Parent = u1;
            task.wait(0.2);
            local v26 = u9:FromInstance(Folder);
            expect(v26).to.be.ok();
            expect(v26.Data).to.equal("abcdef");
            expect(v26.DidHeartbeat).to.equal(true);
            expect(v26.DidStepped).to.equal(RunService:IsRunning());
            expect(v26.DidRenderStepped).to.never.equal(true);
            Folder:Destroy();
            task.wait();
            expect(v26.Data).to.equal("abcdefghi");
        end);
        it("should get another component linked to the same instance", function() -- Line: 155
            -- upvalues: CollectionService (ref), u1 (ref), u9 (ref)
            local Folder = Instance.new("Folder");
            CollectionService:AddTag(Folder, "__KnitTestComponent__");
            Folder.Name = "ComponentTest";
            Folder.Archivable = false;
            Folder.Parent = u1;
            task.wait();
            local v27 = u9:FromInstance(Folder);
            expect(v27).to.be.ok();
            expect(v27.Another).to.be.ok();
            expect(v27.Another:GetData()).to.equal(true);
        end);
        it("should use extension to decide whether or not to construct", function() -- Line: 164
            -- upvalues: script_Parent (ref), CollectionService (ref), u1 (ref)
            local u28 = {
                c = true
            };

            function u28.ShouldConstruct(p29) -- Line: 166
                -- upvalues: u28 (copy)
                return u28.c;
            end;

            local u30 = {
                c = true
            };

            function u30.ShouldConstruct(p31) -- Line: 171
                -- upvalues: u30 (copy)
                return u30.c;
            end;

            local u32 = {
                c = true
            };

            function u32.ShouldConstruct(p33) -- Line: 176
                -- upvalues: u32 (copy)
                return u32.c;
            end;

            local u34 = script_Parent.new({
                Tag = "__KnitTestComponent__",
                Extensions = { u28 }
            });
            local u35 = script_Parent.new({
                Tag = "__KnitTestComponent__",
                Extensions = { u28, u30 }
            });
            local u36 = script_Parent.new({
                Tag = "__KnitTestComponent__",
                Extensions = { u28, u30, u32 }
            });

            local function SetE(p37, p38, p39) -- Line: 184
                -- upvalues: u28 (copy), u30 (copy), u32 (copy)
                u28.c = p37;
                u30.c = p38;
                u32.c = p39;
            end;

            local function Check(p40, p41, p42) -- Line: 190
                local v43 = p41:FromInstance(p40);

                if p42 then
                    expect(v43).to.be.ok();

                    return;
                end;

                expect(v43).to.never.be.ok();
            end;

            local function CreateAndCheckAll(p44, p45, p46) -- Line: 199
                -- upvalues: CollectionService (ref), u1 (ref), Check (copy), u34 (copy), u35 (copy), u36 (copy)
                local Folder = Instance.new("Folder");
                CollectionService:AddTag(Folder, "__KnitTestComponent__");
                Folder.Name = "ComponentTest";
                Folder.Archivable = false;
                Folder.Parent = u1;
                task.wait();
                Check(Folder, u34, p44);
                Check(Folder, u35, p45);
                Check(Folder, u36, p46);
            end;

            u28.c = true;
            u30.c = true;
            u32.c = true;
            local Folder = Instance.new("Folder");
            CollectionService:AddTag(Folder, "__KnitTestComponent__");
            Folder.Name = "ComponentTest";
            Folder.Archivable = false;
            Folder.Parent = u1;
            task.wait();
            local v47 = u34:FromInstance(Folder);
            expect(v47).to.be.ok();
            local v48 = u35:FromInstance(Folder);
            expect(v48).to.be.ok();
            local v49 = u36:FromInstance(Folder);
            expect(v49).to.be.ok();
            u28.c = false;
            u30.c = false;
            u32.c = false;
            local Folder2 = Instance.new("Folder");
            CollectionService:AddTag(Folder2, "__KnitTestComponent__");
            Folder2.Name = "ComponentTest";
            Folder2.Archivable = false;
            Folder2.Parent = u1;
            task.wait();
            local v50 = u34:FromInstance(Folder2);
            expect(v50).to.never.be.ok();
            local v51 = u35:FromInstance(Folder2);
            expect(v51).to.never.be.ok();
            local v52 = u36:FromInstance(Folder2);
            expect(v52).to.never.be.ok();
            u28.c = true;
            u30.c = false;
            u32.c = true;
            local Folder3 = Instance.new("Folder");
            CollectionService:AddTag(Folder3, "__KnitTestComponent__");
            Folder3.Name = "ComponentTest";
            Folder3.Archivable = false;
            Folder3.Parent = u1;
            task.wait();
            local v53 = u34:FromInstance(Folder3);
            expect(v53).to.be.ok();
            local v54 = u35:FromInstance(Folder3);
            expect(v54).to.never.be.ok();
            local v55 = u36:FromInstance(Folder3);
            expect(v55).to.never.be.ok();
            u28.c = false;
            u30.c = false;
            u32.c = true;
            local Folder4 = Instance.new("Folder");
            CollectionService:AddTag(Folder4, "__KnitTestComponent__");
            Folder4.Name = "ComponentTest";
            Folder4.Archivable = false;
            Folder4.Parent = u1;
            task.wait();
            local v56 = u34:FromInstance(Folder4);
            expect(v56).to.never.be.ok();
            local v57 = u35:FromInstance(Folder4);
            expect(v57).to.never.be.ok();
            local v58 = u36:FromInstance(Folder4);
            expect(v58).to.never.be.ok();
        end);
        it("should decide whether or not to use extend", function() -- Line: 224
            -- upvalues: script_Parent (ref), CollectionService (ref), u1 (ref)
            local u59 = {
                extend = true
            };

            function u59.ShouldExtend(p60) -- Line: 226
                -- upvalues: u59 (copy)
                return u59.extend;
            end;

            function u59.Constructing(p61) -- Line: 229
                p61.E1 = true;
            end;

            local u62 = {
                extend = true
            };

            function u62.ShouldExtend(p63) -- Line: 234
                -- upvalues: u62 (copy)
                return u62.extend;
            end;

            function u62.Constructing(p64) -- Line: 237
                p64.E2 = true;
            end;

            local u65 = script_Parent.new({
                Tag = "__KnitTestComponent__",
                Extensions = { u59, u62 }
            });

            local function SetAndCheck(p66, p67) -- Line: 243
                -- upvalues: u59 (copy), u62 (copy), CollectionService (ref), u1 (ref), u65 (copy)
                u59.extend = p66;
                u62.extend = p67;
                local Folder = Instance.new("Folder");
                CollectionService:AddTag(Folder, "__KnitTestComponent__");
                Folder.Name = "ComponentTest";
                Folder.Archivable = false;
                Folder.Parent = u1;
                task.wait();
                local v68 = u65:FromInstance(Folder);
                expect(v68).to.be.ok();

                if p66 then
                    expect(v68.E1).to.equal(true);
                else
                    expect(v68.E1).to.never.be.ok();
                end;

                if p67 then
                    expect(v68.E2).to.equal(true);

                    return;
                end;

                expect(v68.E2).to.never.be.ok();
            end;

            SetAndCheck(true, true);
            SetAndCheck(false, false);
            SetAndCheck(true, false);
            SetAndCheck(false, true);
        end);
        it("should allow yielding within construct", function() -- Line: 268
            -- upvalues: script_Parent (ref), CollectionService (ref)
            local v69 = script_Parent.new({
                Tag = "CustomTag"
            });
            local u70 = 0;

            function v69.Construct(p71) -- Line: 275
                -- upvalues: u70 (ref)
                u70 = u70 + 1;
                task.wait(0.5);
            end;

            local Part = Instance.new("Part");
            Part.Anchored = true;
            Part.Parent = game:GetService("ReplicatedStorage");
            CollectionService:AddTag(Part, "CustomTag");
            local v72 = Part:Clone();
            v72.Parent = workspace;
            task.wait(0.6);
            expect(u70).to.equal(1);
            Part:Destroy();
            v72:Destroy();
        end);
        it("should wait for instance", function() -- Line: 294
            -- upvalues: CollectionService (ref), u9 (ref)
            local Part = Instance.new("Part");
            Part.Anchored = true;
            Part.Parent = workspace;
            task.delay(0.1, function() -- Line: 298
                -- upvalues: CollectionService (ref), Part (copy)
                CollectionService:AddTag(Part, "__KnitTestComponent__");
            end);
            local v73, v74 = u9:WaitForInstance(Part):timeout(1):await();
            expect(v73).to.equal(true);
            expect(v74).to.be.a("table");
            expect(v74.Instance).to.equal(Part);
            Part:Destroy();
        end);
    end);
end;