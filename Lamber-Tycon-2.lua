--loadstring(game:HttpGet("https://raw.githubusercontent.com/Fureyme/Cheats/refs/heads/main/Lamber-Tycon-2.lua"))()
local localPlayer = game:GetService("Players").LocalPlayer
local playerPos = localPlayer.Character.HumanoidRootPart
local Event = game:GetService("ReplicatedStorage").Interaction.RemoteProxy

local firstPlayerPos = CFrame.new(localPlayer.Character.HumanoidRootPart.CFrame.Position)
local isListening = true
local treesCounter = 0
local treeChoping = false                                    ---добав щоб скрипт вибирав найкращий топорик
local fallTree
local logCount = -3
local log
local tool
local characterTool = true
local hitPoints
--Settings
local allSwitch = false
local treeType = "Volcano"
local treeAmount = 3


local function getHitPoint(toolName, treeName)
	local Axes = {
	["BasicHatchet"] = {0.2},
	["Axe1"] = {0.55},
	["Axe2"] = {0.93},
	["Axe3"] = {1.45},
	["SilverAxe"] = {1.6},
	["Rukiryaxe"] = {1.68},
	["EndTimesAxe"] = {1.58, 1000000},
	["BluesteelAxe"] = {2.8, 12.1},
	["AxeAlphaTesters"] = {1.5},
	["AxeBetaTesters"] = {1.45},
	["FireAxe"] = {0.6, 6.35},
	["AxeAmber"] = {3.39},
	["CandyCaneAxe"] = {0},
	["Beesaxe"] = {1.4},
	["AxeChicken"] = {0.9},
	["ManyAxe"] = {10.2},
	["AxeTwitter"] = {1.65, 3.9, 2.5},
	["GingerbreadAxe"] = {1.2, 11, 8.5},
	["RustyAxe"] = {0.55},
	["CandyCornAxe"] = {1.75},
	["CaveAxe"] = {0.4, 7.2},
	["AxeSwamp"] = {0.8, 5.35, 7},
	["IceAxe"] = {0.36, 6},
	["AxePie"] = {0.95, 1.9},
	["MintAxe"] = {0.8},
	["RefinedAxe"] = {0, 12},
	["InverseAxe"] = {-1},
	["AxePig"] = {1.5}
}
	for axeName, hitPoint in pairs(Axes) do
		if toolName == axeName then
			if axeName == "EndTimesAxe" then
				if treeName == "LoneCave" then
					return hitPoint[2]
				end
			elseif axeName == "BluesteelAxe" then
				if treeName == "BlueSpruce" then
					return hitPoint[2]
				end
				
			elseif axeName == "FireAxe" then
				if treeName == "Volcano" then
					return hitPoint[2]
				end
			elseif axeName == "AxeTwitter" then
				if treeName == "CaveCrawler" then
					return hitPoint[2]
				elseif treeName == "Volcano" then
					return hitPoint[3]
				end
			elseif axeName == "GingerbreadAxe" then
				if treeName == "Koa" then
					return hitPoint[2]
				elseif treeName == "Walnut" then
					return hitPoint[3]
				end
			elseif axeName == "CaveAxe" then
				if treeName == "CaveCrawler" then
					return hitPoint[2]
				end	
			elseif axeName == "AxeSwamp" then
				if treeName == "GoldSwampy" then
					return hitPoint[2]
				elseif treeName == "GreenSwampy" then
					return hitPoint[3]
				end
			elseif axeName == "IceAxe" then
				if treeName == "Frost" then
					return hitPoint[2]
				end
			elseif axeName == "AxePie" then
				if treeName == "Cherry" then
					return hitPoint[2]
				end
			else 
				hitPoint[1]
			end
		end
	end
end

if #localPlayer.Backpack:GetChildren() == 0 and not localPlayer.Character:FindFirstChild("Tool") then
	error("Backpack is empty")
end

local inventory = {}

for index, BackpackTool in pairs(localPlayer.Backpack:GetChildren()) do
	inventory[BackpackTool.ToolName.Value] = index
end

local trees = {
	["Generic"] = {nil},
	["Birch"] = {nil},
	["Cherry"] = {"AxePie"},
	["Oak"] = {nil},
	["Walnut"] = {"GingerbreadAxe"},
	["Koa"] = {"GingerbreadAxe"},
	["Fir"] = {nil},
	["Pine"] = {nil},
	["Palm"] = {nil},
	["Volcano"] = {"FireAxe", "AxeTwitter"},
	["SnowGlow"] = {nil},
	["GoldSwampy"] = {"AxeSwamp"},
	["GreenSwampy"] = {"AxeSwamp"},
	["CaveCrawler"] = {"CaveAxe", "AxeTwitter"},
	["Frost"] = {"IceAxe"},
	["LoneCave"] = {"EndTimesAxe"},
	["BlueSpruce"] = {"BluesteelAxe"},
	["Spooky"] = {nil},
	["SpookyNeon"] = {nil},
}

if localPlayer.Character:FindFirstChild("Tool") then
	tool = localPlayer.Character:FindFirstChild("Tool")
	characterTool = false
	hitPoints = getHitPoint(localPlayer.Character:FindFirstChild("Tool").ToolName.Value, treeType)
end

if characterTool then
	for nameTree, nameAxes in pairs(trees) do --получаем список топоров
		if nameTree == treeType then
			for toolName, indexTool in pairs(inventory) do --получаем index топора в Backpack
				if nameAxes == nil then
					hitPoints = getHitPoint(toolName, treeType)
					tool = localPlayer.Backpack:GetChildren()[indexTool]
					break
				end
				for _, nameAxe in pairs(nameAxes) do
					if nameAxe == toolName then
						hitPoints = getHitPoint(nameAxe, treeType)
						print(type(indexTool), indexTool)
						tool = localPlayer.Backpack:GetChildren()[indexTool]
					else 
						hitPoints = getHitPoint(toolName, treeType)
						tool = localPlayer.Backpack:GetChildren()[indexTool]
						break
					end
				end
			end
		end
	end
end



for indexRegion, region in pairs(workspace:GetChildren()) do --Пошук регіонів з деревами
	if region.Name == "TreeRegion" and region.ClassName == "Model" then
		for indexTree, tree in pairs(workspace:GetChildren()[indexRegion]:GetChildren()) do --Пошук дерева
			if tree:FindFirstChild("TreeClass") and tree.TreeClass.Value == treeType then
				for indexLog, WoodSection in pairs(workspace:GetChildren()[indexRegion]:GetChildren()[indexTree]:GetChildren()) do
					if WoodSection.Name == "WoodSection" then
						logCount = logCount + 1
					end
				end

				if logCount <= 0 then
					logCount = -3
					continue
				end

				for indexLog, log in pairs(workspace:GetChildren()[indexRegion]:GetChildren()[indexTree]:GetChildren()) do
					if log.Name == "WoodSection" and log.ID.Value == 1 then
						logCount = -3

						localPlayer.Character.Head.CanCollide = false
						localPlayer.Character.Torso.CanCollide = false

						local teleporting
						teleporting = game:GetService("RunService").Stepped:Connect(function()
							playerPos.CFrame = log.CFrame * CFrame.new(0, 0, 3) --телепот до дерева + переміщеня від дерерва на 3 студа
						end)

						local connection
						connection = workspace.LogModels.ChildAdded:Connect(function(child)
							if child:WaitForChild("TreeClass").Value == treeType and child:WaitForChild("Owner"):WaitForChild("OwnerString").Value == localPlayer.Name then
								fallTree = child
								treeChoping = false
							end
						end)

						--начался ивент рубки
						treeChoping = true
						while treeChoping do 
							--Ивент для рубки дерерва
							Event:FireServer(
								workspace:GetChildren()[indexRegion]:GetChildren()[indexTree].CutEvent,
								{
									height = 0.30, --высота рубки(0.30 мин. значения)
									faceVector = Vector3.new(-1, 0, 0),
									tool = tool,
									sectionId = 1, --низ дерерва
									hitPoints = hitPoints, --Hardened Axe
									cooldown = 0.1,
									cuttingClass = "Axe"
								})
							wait(0.1)
						end

						connection:Disconnect() -- Відключаємо відстеження

						-- Дерево зрублено
						treesCounter = treesCounter + 1

						--Створюємо Dragger
						local Part = fallTree.WoodSection

						-- Створюємо локальний Dragger (як v_u_12 у коді гри)
						local Dragger = Instance.new("Part")
						Dragger.Size = Vector3.new(1, 1, 1)
						Dragger.Transparency = 1
						Dragger.CanCollide = false
						Dragger.CFrame = Part.CFrame
						Dragger.Parent = workspace

						--для сили поворота
						local BodyGyro = Instance.new("BodyGyro", Dragger)
						BodyGyro.CFrame = Part.CFrame
						BodyGyro.D = 140
						BodyGyro.MaxTorque = Vector3.new(5000, 5000, 5000)
						BodyGyro.P = 30000
		
						-- Додаємо BodyPosition для керування фізикою
						local BodyPos = Instance.new("BodyPosition", Dragger)
						BodyPos.MaxForce = Vector3.new(1000000, 1000000, 1000000)
						BodyPos.P = 10000
						BodyPos.D = 800
						BodyPos.Position = Part.Position

						-- Приварюємо дерево до Dragger
						local Weld = Instance.new("Weld", Dragger)
						Weld.Part0 = Dragger
						Weld.Part1 = Part
						Weld.C0 = CFrame.new()
						Weld.C1 = Dragger.CFrame:ToObjectSpace(Part.CFrame)

						-- Запускаем фоновий потік підтримки з'єднання з сервером
						local Dragging = true
						task.spawn(function()
							local Event = game:GetService("ReplicatedStorage").Interaction.ClientIsDragging
							while Dragging do
								Event:FireServer(fallTree)
								task.wait(0.01)
							end
						end)

						teleporting:Disconnect()
						wait(0.3)

						Dragger.CFrame = firstPlayerPos
						fallTree.WoodSection.CFrame = firstPlayerPos
						BodyPos.Position = firstPlayerPos.Position
						BodyGyro.CFrame = firstPlayerPos
						playerPos.CFrame = firstPlayerPos

						Dragger:Destroy()
						Dragging = false
					end

					if treesCounter >= treeAmount and allSwitch == false then
						isListening = false
						localPlayer.Character.Head.CanCollide = true
						localPlayer.Character.Torso.CanCollide = true
						return --break для всіх for
					end
				end
			end
		end
	end
end
