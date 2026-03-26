Library = {}
SaveTheme = {}

local Tw = game:GetService("TweenService")
local U = game:GetService("UserInputService")

-- Fungsi Helper untuk Animasi (Bikin UI lebih hidup)
local function tween(obj, props, time, style, dir)
    time = time or 0.3
    style = style or Enum.EasingStyle.Quint
    dir = dir or Enum.EasingDirection.Out
    local t = Tw:Create(obj, TweenInfo.new(time, style, dir), props)
    t:Play()
    return t
end

-- Tema Premium Modern
local themes = {
	index = {'Premium Dark', 'Midnight Purple'},
	['Premium Dark'] = {
		['Shadow'] = Color3.fromRGB(5, 5, 8),
		['Background'] = Color3.fromRGB(15, 15, 18),
		['Page'] = Color3.fromRGB(20, 20, 25),
		['Main'] = Color3.fromRGB(88, 101, 242), -- Discord Blueish-Purple
		['Text & Icon'] = Color3.fromRGB(240, 240, 245),
		['Muted'] = Color3.fromRGB(130, 130, 140),
		['Element'] = Color3.fromRGB(28, 28, 35),
		['ElementHover'] = Color3.fromRGB(35, 35, 45),
		['Stroke'] = Color3.fromRGB(45, 45, 55)
	},
	['Midnight Purple'] = {
		['Shadow'] = Color3.fromRGB(10, 5, 15),
		['Background'] = Color3.fromRGB(18, 14, 25),
		['Page'] = Color3.fromRGB(24, 18, 35),
		['Main'] = Color3.fromRGB(168, 85, 247), -- Neon Purple
		['Text & Icon'] = Color3.fromRGB(245, 240, 255),
		['Muted'] = Color3.fromRGB(140, 130, 160),
		['Element'] = Color3.fromRGB(35, 25, 50),
		['ElementHover'] = Color3.fromRGB(45, 32, 65),
		['Stroke'] = Color3.fromRGB(60, 45, 85)
	}
}

local existingUI = game:GetService("CoreGui"):FindFirstChild("ADS")
if existingUI then existingUI:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ADS"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = game:GetService("CoreGui")

local IconList = loadstring(game:HttpGet('https://raw.githubusercontent.com/Crytx-X/Crytx/refs/heads/main/Sources/Icons.lua'))()

local function gl(i)
	local iconData = IconList.Icons[i]
	if iconData then
		local spriteSheet = IconList.Spritesheets[tostring(iconData.Image)]
		if spriteSheet then
			return { Image = spriteSheet, ImageRectSize = iconData.ImageRectSize, ImageRectPosition = iconData.ImageRectPosition }
		end
	end
	return { Image = "rbxassetid://".. (type(i) == "number" and i or 0), ImageRectSize = Vector2.new(0, 0), ImageRectPosition = Vector2.new(0, 0) }
end

local function MakeDraggable(topbar, obj)
	local dragging, dragInput, dragStart, startPos
	topbar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true; dragStart = input.Position; startPos = obj.Position
			input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
		end
	end)
	topbar.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
	end)
	U.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			tween(obj, {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}, 0.1)
		end
	end)
end

function Library:Window(p)
	local Title = p.Title or 'Aether Hub'
	local Desc = p.Desc or 'Premium Edition'
	local Icon = p.Icon or 'door-open'
	local Theme = p.Theme or 'Premium Dark'
	local T = themes[Theme] or themes['Premium Dark']

	local Shadow = Instance.new("ImageLabel")
	Shadow.Name = "Shadow"
	Shadow.Parent = ScreenGui
	Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
	Shadow.BackgroundTransparency = 1
	Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	Shadow.Size = p.Config.Size or UDim2.new(0, 550, 0, 420)
	Shadow.Image = "rbxassetid://1316045217"
	Shadow.ImageColor3 = T.Shadow
	Shadow.ImageTransparency = 0.5
	Shadow.ScaleType = Enum.ScaleType.Slice
	Shadow.SliceCenter = Rect.new(10, 10, 118, 118)

	local MainPanel = Instance.new("CanvasGroup")
	MainPanel.Parent = Shadow
	MainPanel.BackgroundColor3 = T.Background
	MainPanel.BorderSizePixel = 0
	MainPanel.Size = UDim2.new(1, -16, 1, -16)
	MainPanel.Position = UDim2.new(0, 8, 0, 8)
	Instance.new("UICorner", MainPanel).CornerRadius = UDim.new(0, 10)
	
	local PanelStroke = Instance.new("UIStroke", MainPanel)
	PanelStroke.Color = T.Stroke
	PanelStroke.Thickness = 1.5
	PanelStroke.Transparency = 0.5

	-- // Topbar
	local Topbar = Instance.new("Frame", MainPanel)
	Topbar.Size = UDim2.new(1, 0, 0, 50)
	Topbar.BackgroundTransparency = 1
	MakeDraggable(Topbar, Shadow)

	local TopbarLine = Instance.new("Frame", Topbar)
	TopbarLine.Size = UDim2.new(1, 0, 0, 1)
	TopbarLine.Position = UDim2.new(0, 0, 1, 0)
	TopbarLine.BackgroundColor3 = T.Stroke
	TopbarLine.BorderSizePixel = 0

	local TopbarIcon = Instance.new("ImageLabel", Topbar)
	local icn = gl(Icon)
	TopbarIcon.Size = UDim2.new(0, 24, 0, 24)
	TopbarIcon.Position = UDim2.new(0, 15, 0.5, -12)
	TopbarIcon.BackgroundTransparency = 1
	TopbarIcon.Image = icn.Image
	TopbarIcon.ImageRectSize = icn.ImageRectSize
	TopbarIcon.ImageRectOffset = icn.ImageRectPosition
	TopbarIcon.ImageColor3 = T['Text & Icon']

	local TopbarTitle = Instance.new("TextLabel", Topbar)
	TopbarTitle.Size = UDim2.new(0, 200, 1, 0)
	TopbarTitle.Position = UDim2.new(0, 48, 0, -5)
	TopbarTitle.BackgroundTransparency = 1
	TopbarTitle.Text = Title
	TopbarTitle.Font = Enum.Font.GothamBold
	TopbarTitle.TextSize = 14
	TopbarTitle.TextColor3 = T['Text & Icon']
	TopbarTitle.TextXAlignment = Enum.TextXAlignment.Left

	local TopbarDesc = Instance.new("TextLabel", Topbar)
	TopbarDesc.Size = UDim2.new(0, 200, 1, 0)
	TopbarDesc.Position = UDim2.new(0, 48, 0, 8)
	TopbarDesc.BackgroundTransparency = 1
	TopbarDesc.Text = Desc
	TopbarDesc.Font = Enum.Font.GothamMedium
	TopbarDesc.TextSize = 11
	TopbarDesc.TextColor3 = T.Muted
	TopbarDesc.TextXAlignment = Enum.TextXAlignment.Left

	-- Close Button
	local CloseBtn = Instance.new("TextButton", Topbar)
	CloseBtn.Size = UDim2.new(0, 30, 0, 30)
	CloseBtn.Position = UDim2.new(1, -40, 0.5, -15)
	CloseBtn.BackgroundColor3 = T.Element
	CloseBtn.Text = ""
	Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
	Instance.new("UIStroke", CloseBtn).Color = T.Stroke

	local CloseIcn = Instance.new("ImageLabel", CloseBtn)
	CloseIcn.Size = UDim2.new(0, 14, 0, 14)
	CloseIcn.Position = UDim2.new(0.5, -7, 0.5, -7)
	CloseIcn.BackgroundTransparency = 1
	CloseIcn.Image = "rbxassetid://15082305656"
	CloseIcn.ImageColor3 = T.Muted

	CloseBtn.MouseEnter:Connect(function()
		tween(CloseBtn, {BackgroundColor3 = Color3.fromRGB(255, 60, 60)})
		tween(CloseIcn, {ImageColor3 = Color3.fromRGB(255, 255, 255)})
	end)
	CloseBtn.MouseLeave:Connect(function()
		tween(CloseBtn, {BackgroundColor3 = T.Element})
		tween(CloseIcn, {ImageColor3 = T.Muted})
	end)
	CloseBtn.MouseButton1Click:Connect(function()
		if p.OnClose then pcall(p.OnClose) end
		ScreenGui:Destroy()
	end)

	-- // Sidebar (Tabs)
	local Sidebar = Instance.new("ScrollingFrame", MainPanel)
	Sidebar.Size = UDim2.new(0, 140, 1, -51)
	Sidebar.Position = UDim2.new(0, 0, 0, 51)
	Sidebar.BackgroundTransparency = 1
	Sidebar.BorderSizePixel = 0
	Sidebar.ScrollBarThickness = 0

	local SidebarLayout = Instance.new("UIListLayout", Sidebar)
	SidebarLayout.Padding = UDim.new(0, 4)
	SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	Instance.new("UIPadding", Sidebar).PaddingTop = UDim.new(0, 10)

	local SidebarLine = Instance.new("Frame", MainPanel)
	SidebarLine.Size = UDim2.new(0, 1, 1, -51)
	SidebarLine.Position = UDim2.new(0, 140, 0, 51)
	SidebarLine.BackgroundColor3 = T.Stroke
	SidebarLine.BorderSizePixel = 0

	-- // Pages Container
	local PagesContainer = Instance.new("Frame", MainPanel)
	PagesContainer.Size = UDim2.new(1, -141, 1, -51)
	PagesContainer.Position = UDim2.new(0, 141, 0, 51)
	PagesContainer.BackgroundTransparency = 1

	local Tabs = {List = {}}
	local ActiveTab = nil

	-- Animation Open Window
	MainPanel.Size = UDim2.new(0.9, 0, 0.9, 0)
	MainPanel.GroupTransparency = 1
	tween(MainPanel, {Size = UDim2.new(1, -16, 1, -16), GroupTransparency = 0}, 0.5, Enum.EasingStyle.Quint)

	-- // Tab Function
	function Tabs:Tab(tp)
		local tTitle = tp.Title or "Tab"
		local tIcon = tp.Icon or "box"
		
		local TabBtn = Instance.new("TextButton", Sidebar)
		TabBtn.Size = UDim2.new(0, 120, 0, 32)
		TabBtn.BackgroundColor3 = T.Element
		TabBtn.BackgroundTransparency = 1
		TabBtn.Text = ""
		Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

		local TIcon = Instance.new("ImageLabel", TabBtn)
		local ic = gl(tIcon)
		TIcon.Size = UDim2.new(0, 16, 0, 16)
		TIcon.Position = UDim2.new(0, 10, 0.5, -8)
		TIcon.BackgroundTransparency = 1
		TIcon.Image = ic.Image
		TIcon.ImageRectSize = ic.ImageRectSize
		TIcon.ImageRectOffset = ic.ImageRectPosition
		TIcon.ImageColor3 = T.Muted

		local TLabel = Instance.new("TextLabel", TabBtn)
		TLabel.Size = UDim2.new(1, -35, 1, 0)
		TLabel.Position = UDim2.new(0, 35, 0, 0)
		TLabel.BackgroundTransparency = 1
		TLabel.Text = tTitle
		TLabel.Font = Enum.Font.GothamSemibold
		TLabel.TextSize = 12
		TLabel.TextColor3 = T.Muted
		TLabel.TextXAlignment = Enum.TextXAlignment.Left

		local Indicator = Instance.new("Frame", TabBtn)
		Indicator.Size = UDim2.new(0, 3, 0, 10)
		Indicator.Position = UDim2.new(0, 0, 0.5, -5)
		Indicator.BackgroundColor3 = T.Main
		Indicator.BorderSizePixel = 0
		Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)
		Indicator.BackgroundTransparency = 1

		local PageScroll = Instance.new("ScrollingFrame", PagesContainer)
		PageScroll.Size = UDim2.new(1, 0, 1, 0)
		PageScroll.BackgroundTransparency = 1
		PageScroll.ScrollBarThickness = 2
		PageScroll.ScrollBarImageColor3 = T.Main
		PageScroll.Visible = false
		PageScroll.BorderSizePixel = 0

		local PLayout = Instance.new("UIListLayout", PageScroll)
		PLayout.Padding = UDim.new(0, 8)
		PLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		
		local PPadding = Instance.new("UIPadding", PageScroll)
		PPadding.PaddingTop = UDim.new(0, 15)
		PPadding.PaddingBottom = UDim.new(0, 15)

		PLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			PageScroll.CanvasSize = UDim2.new(0, 0, 0, PLayout.AbsoluteContentSize.Y + 30)
		end)

		local function ActivateTab()
			if ActiveTab == TabBtn then return end
			if ActiveTab then
				ActiveTab.Page.Visible = false
				tween(ActiveTab.Btn, {BackgroundTransparency = 1}, 0.3)
				tween(ActiveTab.Lbl, {TextColor3 = T.Muted}, 0.3)
				tween(ActiveTab.Icn, {ImageColor3 = T.Muted}, 0.3)
				tween(ActiveTab.Ind, {Size = UDim2.new(0, 3, 0, 10), BackgroundTransparency = 1}, 0.3)
			end

			ActiveTab = {Btn = TabBtn, Lbl = TLabel, Icn = TIcon, Ind = Indicator, Page = PageScroll}
			PageScroll.Visible = true
			
			-- Bouncy intro animation for page elements
			for _, child in pairs(PageScroll:GetChildren()) do
				if child:IsA("Frame") then
					child.Position = UDim2.new(0.5, 0, 0, 0)
					child.GroupTransparency = 1
					tween(child, {Position = UDim2.new(0, 0, 0, 0), GroupTransparency = 0}, 0.4, Enum.EasingStyle.Back)
					task.wait(0.02)
				end
			end

			tween(TabBtn, {BackgroundTransparency = 0}, 0.3)
			tween(TLabel, {TextColor3 = T['Text & Icon']}, 0.3)
			tween(TIcon, {ImageColor3 = T['Text & Icon']}, 0.3)
			tween(Indicator, {Size = UDim2.new(0, 3, 0, 20), BackgroundTransparency = 0}, 0.3, Enum.EasingStyle.Back)
		end

		TabBtn.MouseButton1Click:Connect(ActivateTab)
		TabBtn.MouseEnter:Connect(function() if ActiveTab ~= TabBtn then tween(TLabel, {TextColor3 = T['Text & Icon']}, 0.2); tween(TIcon, {ImageColor3 = T['Text & Icon']}, 0.2) end end)
		TabBtn.MouseLeave:Connect(function() if ActiveTab ~= TabBtn then tween(TLabel, {TextColor3 = T.Muted}, 0.2); tween(TIcon, {ImageColor3 = T.Muted}, 0.2) end end)

		if #Tabs.List == 0 then ActivateTab() end
		table.insert(Tabs.List, TabBtn)

		local Elements = {}

		function Elements:Section(sp)
			local sTitle = sp.Title or "Section"
			local SecLabel = Instance.new("TextLabel", PageScroll)
			SecLabel.Size = UDim2.new(1, -30, 0, 20)
			SecLabel.BackgroundTransparency = 1
			SecLabel.Text = sTitle:upper()
			SecLabel.Font = Enum.Font.GothamBold
			SecLabel.TextSize = 11
			SecLabel.TextColor3 = T.Main
			SecLabel.TextXAlignment = Enum.TextXAlignment.Left
		end

		local function CreateBaseFrame(height)
			local frame = Instance.new("CanvasGroup", PageScroll)
			frame.Size = UDim2.new(1, -30, 0, height)
			frame.BackgroundColor3 = T.Element
			frame.BorderSizePixel = 0
			Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
			local stroke = Instance.new("UIStroke", frame)
			stroke.Color = T.Stroke
			stroke.Transparency = 0.3
			return frame, stroke
		end

		function Elements:Toggle(tp)
			local tTitle = tp.Title or "Toggle"
			local tDesc = tp.Desc or ""
			local tVal = tp.Value or false
			local tCall = tp.Callback or function() end

			local bg, stroke = CreateBaseFrame(45)

			local Lbl = Instance.new("TextLabel", bg)
			Lbl.Size = UDim2.new(1, -70, 0, 20)
			Lbl.Position = UDim2.new(0, 15, 0, 5)
			Lbl.BackgroundTransparency = 1
			Lbl.Text = tTitle
			Lbl.Font = Enum.Font.GothamBold
			Lbl.TextSize = 13
			Lbl.TextColor3 = T['Text & Icon']
			Lbl.TextXAlignment = Enum.TextXAlignment.Left

			local DescLbl = Instance.new("TextLabel", bg)
			DescLbl.Size = UDim2.new(1, -70, 0, 15)
			DescLbl.Position = UDim2.new(0, 15, 0, 25)
			DescLbl.BackgroundTransparency = 1
			DescLbl.Text = tDesc
			DescLbl.Font = Enum.Font.Gotham
			DescLbl.TextSize = 11
			DescLbl.TextColor3 = T.Muted
			DescLbl.TextXAlignment = Enum.TextXAlignment.Left
			DescLbl.TextTruncate = Enum.TextTruncate.AtEnd

			-- iOS Style Toggle Pill
			local Pill = Instance.new("Frame", bg)
			Pill.Size = UDim2.new(0, 44, 0, 22)
			Pill.Position = UDim2.new(1, -55, 0.5, -11)
			Pill.BackgroundColor3 = tVal and T.Main or Color3.fromRGB(50, 50, 60)
			Instance.new("UICorner", Pill).CornerRadius = UDim.new(1, 0)

			local Circle = Instance.new("Frame", Pill)
			Circle.Size = UDim2.new(0, 18, 0, 18)
			Circle.Position = tVal and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
			Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

			local Btn = Instance.new("TextButton", bg)
			Btn.Size = UDim2.new(1, 0, 1, 0)
			Btn.BackgroundTransparency = 1
			Btn.Text = ""

			Btn.MouseButton1Click:Connect(function()
				tVal = not tVal
				tween(Pill, {BackgroundColor3 = tVal and T.Main or Color3.fromRGB(50, 50, 60)}, 0.2)
				tween(Circle, {Position = tVal and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)}, 0.3, Enum.EasingStyle.Back)
				pcall(tCall, tVal)
			end)

			Btn.MouseEnter:Connect(function() tween(stroke, {Color = T.Main}, 0.2) end)
			Btn.MouseLeave:Connect(function() tween(stroke, {Color = T.Stroke}, 0.2) end)
		end

		function Elements:Button(bp)
			local bTitle = bp.Title or "Button"
			local bCall = bp.Callback or function() end

			local bg, stroke = CreateBaseFrame(35)
			bg.BackgroundColor3 = T.Main

			-- Gradient for Premium Look
			local Grad = Instance.new("UIGradient", bg)
			Grad.Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0, Color3.new(1,1,1)),
				ColorSequenceKeypoint.new(1, Color3.new(0.8, 0.8, 0.8))
			}
			Grad.Rotation = 45

			local Lbl = Instance.new("TextLabel", bg)
			Lbl.Size = UDim2.new(1, 0, 1, 0)
			Lbl.BackgroundTransparency = 1
			Lbl.Text = bTitle
			Lbl.Font = Enum.Font.GothamBold
			Lbl.TextSize = 13
			Lbl.TextColor3 = Color3.fromRGB(255, 255, 255)

			local Btn = Instance.new("TextButton", bg)
			Btn.Size = UDim2.new(1, 0, 1, 0)
			Btn.BackgroundTransparency = 1
			Btn.Text = ""

			Btn.MouseEnter:Connect(function() tween(bg, {Size = UDim2.new(1, -28, 0, 37)}, 0.2, Enum.EasingStyle.Back) end)
			Btn.MouseLeave:Connect(function() tween(bg, {Size = UDim2.new(1, -30, 0, 35)}, 0.2, Enum.EasingStyle.Back) end)
			Btn.MouseButton1Down:Connect(function() tween(bg, {Size = UDim2.new(1, -34, 0, 33)}, 0.1) end)
			Btn.MouseButton1Up:Connect(function() tween(bg, {Size = UDim2.new(1, -28, 0, 37)}, 0.2, Enum.EasingStyle.Back); pcall(bCall) end)
		end

		function Elements:Slider(sp)
			local sTitle = sp.Title or "Slider"
			local sMin = sp.Min or 0
			local sMax = sp.Max or 100
			local sVal = sp.Value or 50
			local sCall = sp.Callback or function() end

			local bg, stroke = CreateBaseFrame(55)

			local Lbl = Instance.new("TextLabel", bg)
			Lbl.Size = UDim2.new(1, -20, 0, 20)
			Lbl.Position = UDim2.new(0, 15, 0, 5)
			Lbl.BackgroundTransparency = 1
			Lbl.Text = sTitle
			Lbl.Font = Enum.Font.GothamBold
			Lbl.TextSize = 13
			Lbl.TextColor3 = T['Text & Icon']
			Lbl.TextXAlignment = Enum.TextXAlignment.Left

			local ValBox = Instance.new("TextBox", bg)
			ValBox.Size = UDim2.new(0, 40, 0, 20)
			ValBox.Position = UDim2.new(1, -55, 0, 5)
			ValBox.BackgroundColor3 = T.Background
			ValBox.Text = tostring(sVal)
			ValBox.Font = Enum.Font.GothamMedium
			ValBox.TextSize = 12
			ValBox.TextColor3 = T['Text & Icon']
			Instance.new("UICorner", ValBox).CornerRadius = UDim.new(0, 4)

			local SliderTrack = Instance.new("Frame", bg)
			SliderTrack.Size = UDim2.new(1, -30, 0, 6)
			SliderTrack.Position = UDim2.new(0, 15, 0, 35)
			SliderTrack.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
			Instance.new("UICorner", SliderTrack).CornerRadius = UDim.new(1, 0)

			local SliderFill = Instance.new("Frame", SliderTrack)
			SliderFill.Size = UDim2.new((sVal - sMin)/(sMax - sMin), 0, 1, 0)
			SliderFill.BackgroundColor3 = T.Main
			Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)

			local Knob = Instance.new("Frame", SliderFill)
			Knob.Size = UDim2.new(0, 14, 0, 14)
			Knob.Position = UDim2.new(1, -7, 0.5, -7)
			Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)
			
			local Btn = Instance.new("TextButton", SliderTrack)
			Btn.Size = UDim2.new(1, 0, 1, 20)
			Btn.Position = UDim2.new(0, 0, 0.5, -10)
			Btn.BackgroundTransparency = 1
			Btn.Text = ""

			local dragging = false
			local function update(input)
				local percent = math.clamp((input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
				local val = math.floor(sMin + (sMax - sMin) * percent)
				sVal = val
				ValBox.Text = tostring(val)
				tween(SliderFill, {Size = UDim2.new(percent, 0, 1, 0)}, 0.1)
				pcall(sCall, val)
			end

			Btn.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true; tween(Knob, {Size = UDim2.new(0, 18, 0, 18), Position = UDim2.new(1, -9, 0.5, -9)}, 0.2); update(input)
				end
			end)
			U.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = false; tween(Knob, {Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(1, -7, 0.5, -7)}, 0.2)
				end
			end)
			U.InputChanged:Connect(function(input)
				if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then update(input) end
			end)
			
			bg.MouseEnter:Connect(function() tween(stroke, {Color = T.Main}, 0.2) end)
			bg.MouseLeave:Connect(function() tween(stroke, {Color = T.Stroke}, 0.2) end)

			return {SetValue = function(self, val) ValBox.Text = tostring(val); tween(SliderFill, {Size = UDim2.new((val - sMin)/(sMax - sMin), 0, 1, 0)}, 0.2) end}
		end

		function Elements:Textbox(tp)
			local tTitle = tp.Title or "Textbox"
			local tPlace = tp.Placeholder or "Type here..."
			local tVal = tp.Value or ""
			local tCall = tp.Callback or function() end

			local bg, stroke = CreateBaseFrame(40)

			local Lbl = Instance.new("TextLabel", bg)
			Lbl.Size = UDim2.new(0.4, 0, 1, 0)
			Lbl.Position = UDim2.new(0, 15, 0, 0)
			Lbl.BackgroundTransparency = 1
			Lbl.Text = tTitle
			Lbl.Font = Enum.Font.GothamBold
			Lbl.TextSize = 13
			Lbl.TextColor3 = T['Text & Icon']
			Lbl.TextXAlignment = Enum.TextXAlignment.Left

			local Box = Instance.new("TextBox", bg)
			Box.Size = UDim2.new(0.5, -15, 0, 26)
			Box.Position = UDim2.new(0.5, 0, 0.5, -13)
			Box.BackgroundColor3 = T.Background
			Box.Text = tVal
			Box.PlaceholderText = tPlace
			Box.Font = Enum.Font.GothamMedium
			Box.TextSize = 12
			Box.TextColor3 = T['Text & Icon']
			Box.ClearTextOnFocus = tp.ClearTextOnFocus == nil and true or tp.ClearTextOnFocus
			Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 6)
			local boxStroke = Instance.new("UIStroke", Box)
			boxStroke.Color = T.Stroke

			Box.Focused:Connect(function() tween(boxStroke, {Color = T.Main}, 0.3) end)
			Box.FocusLost:Connect(function() tween(boxStroke, {Color = T.Stroke}, 0.3); pcall(tCall, Box.Text) end)
			bg.MouseEnter:Connect(function() tween(stroke, {Color = T.Main}, 0.2) end)
			bg.MouseLeave:Connect(function() tween(stroke, {Color = T.Stroke}, 0.2) end)
		end

		function Elements:Dropdown(dp)
			local dTitle = dp.Title or "Dropdown"
			local dList = dp.List or {}
			local dVal = dp.Value or ""
			local dCall = dp.Callback or function() end
			local isOpen = false

			local bg, stroke = CreateBaseFrame(40)
			
			local Lbl = Instance.new("TextLabel", bg)
			Lbl.Size = UDim2.new(0.5, 0, 0, 40)
			Lbl.Position = UDim2.new(0, 15, 0, 0)
			Lbl.BackgroundTransparency = 1
			Lbl.Text = dTitle
			Lbl.Font = Enum.Font.GothamBold
			Lbl.TextSize = 13
			Lbl.TextColor3 = T['Text & Icon']
			Lbl.TextXAlignment = Enum.TextXAlignment.Left

			local SelectedBox = Instance.new("Frame", bg)
			SelectedBox.Size = UDim2.new(0.4, 0, 0, 26)
			SelectedBox.Position = UDim2.new(0.6, -15, 0, 7)
			SelectedBox.BackgroundColor3 = T.Background
			Instance.new("UICorner", SelectedBox).CornerRadius = UDim.new(0, 6)
			Instance.new("UIStroke", SelectedBox).Color = T.Stroke

			local SelText = Instance.new("TextLabel", SelectedBox)
			SelText.Size = UDim2.new(1, -25, 1, 0)
			SelText.Position = UDim2.new(0, 5, 0, 0)
			SelText.BackgroundTransparency = 1
			SelText.Text = type(dVal) == "table" and "Multiple" or tostring(dVal)
			SelText.Font = Enum.Font.GothamMedium
			SelText.TextSize = 11
			SelText.TextColor3 = T['Text & Icon']
			SelText.TextXAlignment = Enum.TextXAlignment.Left
			SelText.TextTruncate = Enum.TextTruncate.AtEnd

			local Arrow = Instance.new("ImageLabel", SelectedBox)
			Arrow.Size = UDim2.new(0, 16, 0, 16)
			Arrow.Position = UDim2.new(1, -20, 0.5, -8)
			Arrow.BackgroundTransparency = 1
			Arrow.Image = "rbxassetid://14937709869"
			Arrow.ImageColor3 = T.Muted

			local ItemContainer = Instance.new("Frame", bg)
			ItemContainer.Size = UDim2.new(1, -30, 0, 0)
			ItemContainer.Position = UDim2.new(0, 15, 0, 40)
			ItemContainer.BackgroundTransparency = 1
			ItemContainer.ClipsDescendants = true

			local ItemLayout = Instance.new("UIListLayout", ItemContainer)
			ItemLayout.Padding = UDim.new(0, 4)
			
			local Btn = Instance.new("TextButton", bg)
			Btn.Size = UDim2.new(1, 0, 0, 40)
			Btn.BackgroundTransparency = 1
			Btn.Text = ""

			local function ToggleDrop()
				isOpen = not isOpen
				local targetHeight = isOpen and (45 + (math.min(#dList, 5) * 28)) or 40
				tween(bg, {Size = UDim2.new(1, -30, 0, targetHeight)}, 0.4, Enum.EasingStyle.Exponential)
				tween(ItemContainer, {Size = UDim2.new(1, -30, 0, targetHeight - 45)}, 0.4, Enum.EasingStyle.Exponential)
				tween(Arrow, {Rotation = isOpen and 180 or 0}, 0.3)
			end

			Btn.MouseButton1Click:Connect(ToggleDrop)

			local function RenderItems()
				for _, child in pairs(ItemContainer:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
				for _, item in ipairs(dList) do
					local iBtn = Instance.new("TextButton", ItemContainer)
					iBtn.Size = UDim2.new(1, 0, 0, 24)
					iBtn.BackgroundColor3 = T.Background
					iBtn.Text = "  " .. tostring(item)
					iBtn.Font = Enum.Font.GothamMedium
					iBtn.TextSize = 11
					iBtn.TextColor3 = T.Muted
					iBtn.TextXAlignment = Enum.TextXAlignment.Left
					Instance.new("UICorner", iBtn).CornerRadius = UDim.new(0, 4)

					iBtn.MouseEnter:Connect(function() tween(iBtn, {BackgroundColor3 = T.ElementHover, TextColor3 = T['Text & Icon']}, 0.2) end)
					iBtn.MouseLeave:Connect(function() tween(iBtn, {BackgroundColor3 = T.Background, TextColor3 = T.Muted}, 0.2) end)
					iBtn.MouseButton1Click:Connect(function()
						SelText.Text = tostring(item)
						pcall(dCall, item)
						ToggleDrop()
					end)
				end
			end
			RenderItems()

			bg.MouseEnter:Connect(function() tween(stroke, {Color = T.Main}, 0.2) end)
			bg.MouseLeave:Connect(function() tween(stroke, {Color = T.Stroke}, 0.2) end)

			return {Clear = function() dList = {}; RenderItems() end, Add = function(self, val) table.insert(dList, val); RenderItems() end}
		end

		function Elements:Label(lp)
			local bg = Instance.new("Frame", PageScroll)
			bg.Size = UDim2.new(1, -30, 0, 30)
			bg.BackgroundTransparency = 1

			local Lbl = Instance.new("TextLabel", bg)
			Lbl.Size = UDim2.new(1, 0, 1, 0)
			Lbl.BackgroundTransparency = 1
			Lbl.Text = lp.Title or "Label"
			Lbl.Font = Enum.Font.GothamMedium
			Lbl.TextSize = 12
			Lbl.TextColor3 = T.Muted
			Lbl.TextXAlignment = Enum.TextXAlignment.Left
			Lbl.RichText = true

			return {SetTitle = function(self, txt) Lbl.Text = txt end}
		end

		-- Simple Logger Implementation
		function Elements:CreateLogger(lp)
			local bg, stroke = CreateBaseFrame(200)
			local ltitle = Instance.new("TextLabel", bg)
			ltitle.Size = UDim2.new(1, -20, 0, 20)
			ltitle.Position = UDim2.new(0, 10, 0, 5)
			ltitle.BackgroundTransparency = 1
			ltitle.Text = lp.Title or "Logs"
			ltitle.Font = Enum.Font.GothamBold
			ltitle.TextColor3 = T.Main
			ltitle.TextXAlignment = Enum.TextXAlignment.Left
			ltitle.TextSize = 12

			local scroll = Instance.new("ScrollingFrame", bg)
			scroll.Size = UDim2.new(1, -20, 1, -35)
			scroll.Position = UDim2.new(0, 10, 0, 30)
			scroll.BackgroundTransparency = 1
			scroll.ScrollBarThickness = 2
			scroll.BorderSizePixel = 0
			local list = Instance.new("UIListLayout", scroll)
			list.Padding = UDim.new(0, 2)
			
			list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				scroll.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y)
				scroll.CanvasPosition = Vector2.new(0, list.AbsoluteContentSize.Y)
			end)

			return {
				Log = function(self, msg)
					local txt = Instance.new("TextLabel", scroll)
					txt.Size = UDim2.new(1, 0, 0, 15)
					txt.BackgroundTransparency = 1
					txt.Text = " > " .. tostring(msg)
					txt.Font = Enum.Font.Code
					txt.TextColor3 = T['Text & Icon']
					txt.TextSize = 11
					txt.TextXAlignment = Enum.TextXAlignment.Left
					txt.TextWrapped = true
				end,
				Clear = function(self)
					for _, c in pairs(scroll:GetChildren()) do if c:IsA("TextLabel") then c:Destroy() end end
				end
			}
		end

		return Elements
	end

	-- Notifications (Slide & Bounce from Top Right)
	local NotifyContainer = Instance.new("Frame", ScreenGui)
	NotifyContainer.Size = UDim2.new(0, 250, 1, -20)
	NotifyContainer.Position = UDim2.new(1, -260, 0, 10)
	NotifyContainer.BackgroundTransparency = 1
	local NotifLayout = Instance.new("UIListLayout", NotifyContainer)
	NotifLayout.SortOrder = Enum.SortOrder.LayoutOrder
	NotifLayout.Padding = UDim.new(0, 10)
	NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom

	function Library:Notify(np)
		local Title = np.Title or "Notification"
		local Desc = np.Desc or "Message goes here"
		local Time = np.Time or 3

		local Notif = Instance.new("CanvasGroup", NotifyContainer)
		Notif.Size = UDim2.new(1, 0, 0, 60)
		Notif.BackgroundColor3 = T.Background
		Instance.new("UICorner", Notif).CornerRadius = UDim.new(0, 8)
		Instance.new("UIStroke", Notif).Color = T.Stroke

		local Bar = Instance.new("Frame", Notif)
		Bar.Size = UDim2.new(0, 3, 1, 0)
		Bar.BackgroundColor3 = np.Type == "error" and Color3.fromRGB(255, 80, 80) or T.Main
		Bar.BorderSizePixel = 0

		local NTitle = Instance.new("TextLabel", Notif)
		NTitle.Size = UDim2.new(1, -20, 0, 20)
		NTitle.Position = UDim2.new(0, 12, 0, 5)
		NTitle.BackgroundTransparency = 1
		NTitle.Text = Title
		NTitle.Font = Enum.Font.GothamBold
		NTitle.TextColor3 = T['Text & Icon']
		NTitle.TextSize = 12
		NTitle.TextXAlignment = Enum.TextXAlignment.Left

		local NDesc = Instance.new("TextLabel", Notif)
		NDesc.Size = UDim2.new(1, -20, 0, 30)
		NDesc.Position = UDim2.new(0, 12, 0, 25)
		NDesc.BackgroundTransparency = 1
		NDesc.Text = Desc
		NDesc.Font = Enum.Font.Gotham
		NDesc.TextColor3 = T.Muted
		NDesc.TextSize = 11
		NDesc.TextWrapped = true
		NDesc.TextXAlignment = Enum.TextXAlignment.Left
		NDesc.TextYAlignment = Enum.TextYAlignment.Top

		-- Anim In
		Notif.Position = UDim2.new(1, 300, 0, 0)
		Notif.GroupTransparency = 1
		tween(Notif, {Position = UDim2.new(0, 0, 0, 0), GroupTransparency = 0}, 0.5, Enum.EasingStyle.Back)

		task.delay(Time, function()
			local t = tween(Notif, {Position = UDim2.new(1, 300, 0, 0), GroupTransparency = 1}, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In)
			t.Completed:Connect(function() Notif:Destroy() end)
		end)
	end
	
	-- Function Handle Window Show/Hide
	local isHidden = false
	U.InputBegan:Connect(function(k, gp)
		if not gp and k.KeyCode == (p.Config.Keybind or Enum.KeyCode.LeftControl) then
			isHidden = not isHidden
			if isHidden then
				tween(MainPanel, {Size = UDim2.new(0.9, 0, 0.9, 0), GroupTransparency = 1}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
				task.delay(0.2, function() Shadow.Visible = false end)
			else
				Shadow.Visible = true
				tween(MainPanel, {Size = UDim2.new(1, -16, 1, -16), GroupTransparency = 0}, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
			end
		end
	end)

	return Tabs
end

return Library