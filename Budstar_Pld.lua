-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'BDT', 'Reraise', 'Charm')
    state.MagicalDefenseMode:options('MDT', 'BDT', 'Reraise', 'Charm')
    
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Knockback', 'MP_Knockback'}
    state.EquipShield = M(false, 'Equip Shield w/Defense')

    update_defense_mode()
    
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
    send_command('bind @f10 gs c toggle EquipShield')
    send_command('bind @f11 gs c toggle EquipShield')

    select_default_macro_book()
end

function user_unload()
    send_command('unbind ^f11')
    send_command('unbind !f11')
    send_command('unbind @f10')
    send_command('unbind @f11')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    sets.enmity = {
		ammo="Paeapua",
        head="Loess Barbuta +1",
		neck="Unmoving Collar +1",
        body="Souveran Cuirass",
		hands="Yorium Gauntlets",
		ring1="Apeile Ring",
		ring2="Apeile Ring +1",
        back="Weard Mantle",
		waist="Creed Baudrier",
		legs="Souveran Diechlings +1",
		feet="Eschite Greaves"}
    --------------------------------------
    -- Precast sets
    --------------------------------------
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = {legs="Caballarius Breeches"}
    sets.precast.JA['Holy Circle'] = sets.enmity
    sets.precast.JA['Shield Bash'] = {hands="Caballarius Gauntlets",waist="Chaac Belt"}
    sets.precast.JA['Sentinel'] = {feet="Caballarius Leggings"}
    sets.precast.JA['Rampart'] = {head="Caballarius Coronet"}
    sets.precast.JA['Fealty'] = {body="Caballarius Surcoat"}
    sets.precast.JA['Divine Emblem'] = {feet="Creed Sabatons +2"}
    sets.precast.JA['Cover'] = {head="Reverence Coronet +1"}
	sets.precast.JA['Provoke'] = sets.enmity
	sets.precast.JA['Warcry'] = sets.enmity
	sets.precast.JA['Palisade'] = sets.enmity
	sets.precast.JA['Defender'] = sets.enmity
	
    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
        head="Carmine Mask",
        body="Souveran Cuirass",
		hands="Caballarius Gauntlets",
		ring1="Aquasoul Ring",
		ring2="Aquasoul Ring",
        back="Weard Mantle",
		legs="Chevalier's Cuisses +1",
		feet="Carmine Greaves"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		ammo="Sonia's Plectrum",
        head="Ighwa Cap",
        body="Souveran Cuirass",
		hands="Caballarius Gauntlets",
		ring1="Aquasoul Ring",
		ring2="Aquasoul Ring",
        back="Weard Mantle",
		legs="Chevalier's Cuisses +1",
		feet="Whirlpool Greaves"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {waist="Chaac Belt"}
    sets.precast.Flourish1 = {waist="Chaac Belt"}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
		ammo="Incantor Stone",
        head="Carmine Mask",
		neck="Sanctity Necklace",
		body="Reverence Surcoat +2",
		hands="Leyline Gloves",
		ear1="Loquacious Earring",
		ear2="Etiolation Earring",
		ring1="K'ayres Ring",
		ring2="Meridian Ring",
		waist="Cetl Belt",
		back={ name="Rudianos's Mantle", augments={'HP+60','"Fast Cast"+10','Eva.+20 /Mag. Eva.+20',}},
		legs="Eschite Cuisses",
		feet={ name="Odyssean Greaves", augments={'Agi+4','"Mag. Acc."+2','"Mag.Atk.Bns"+6','"Fast Cast"+6',}},}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		ear1="Mendi. Earring",
		ear2="Nourish. Earring +1",
		body="Jumalik Mail"})
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Hasty Pinion +1",
        head="Sulevia's Mask +2",
		neck="Fotia Gorget",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
        body="Sulevia's Plate. +1",
		hands="Odyssean Gauntlets",
		ring1="Rajas Ring",
		ring2="Strigoi Ring",
        back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
		waist="Metalsinger Belt",
		legs="Odyssean Cuisses",
		feet="Sulev. Leggings +2"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = {
		ammo="Paeapua",
		head="Flam. Zucchetto +2",
		body="Sulevia's Plate. +2",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Sulev. Leggings +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Rufescent Ring",
		right_ring="Aquasoul Ring",
		back="Atheling Mantle",}
    
    sets.precast.WS['Chant du Cygne'] = {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body="Flamma Korazin +1",
		hands="Flam. Manopolas +2",
		legs={ name="Valor. Hose", augments={'Accuracy+23','Crit. hit damage +2%','STR+7',}},
		feet="Thereoid Greaves",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear="Lugra Earring",
		left_ring="Apate Ring",
		right_ring="Begrudging Ring",
		back="Ground. Mantle +1",}
  
	sets.precast.WS['Savage Blade'] = {
		ammo="Ginsen",
		head={ name="Odyssean Helm", augments={'Accuracy+27','Weapon skill damage +5%','DEX+6',}},
		body="Sulevia's Plate. +2",
		hands={ name="Odyssean Gauntlets", augments={'Weapon skill damage +3%','VIT+8','Accuracy+11',}},
		legs={ name="Odyssean Cuisses", augments={'Pet: "Mag.Atk.Bns."+26','Pet: DEX+10','Weapon skill damage +5%','Accuracy+17 Attack+17',}},
		feet="Sulev. Leggings +2",
		neck="Fotia Gorget",
		waist="Metalsinger Belt",
		left_ear="Brutal Earring",
		right_ear="Digni. Earring",
		left_ring="Rufescent Ring",
		right_ring="Strigoi Ring",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}
   
	sets.precast.WS['Resolution'] = {
		ammo="Hasty Pinion +1",
        head="Sulevia's Mask +2",
		neck="Fotia Gorget",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
        body="Sulevia's Plate. +1",
		hands="Odyssean Gauntlets",
		ring1="Rajas Ring",
		ring2="Cacoethic Ring +1",
        back="Ground. Mantle +1",
		waist="Fotia Belt",
		legs="Odyssean Cuisses",
		feet="Sulevia's Leggings +2"}

	sets.precast.WS['Torcleaver'] = {
		ammo="Hasty Pinion +1",
        head="Odyssean Helm",
		neck="Fotia Gorget",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
        body="Sulevia's Plate. +1",
		hands="Odyssean Gauntlets",
		ring1="Rajas Ring",
		ring2="Rufescent Ring",
        back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
		waist="Fotia Belt",
		legs="Odyssean Cuisses",
		feet="Sulev. Leggings +2"}

	sets.precast.WS['Scourge'] = {
		ammo="Hasty Pinion +1",
        head="Odyssean Helm",
		neck="Fotia Gorget",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
        body="Sulevia's Plate. +1",
		hands="Odyssean Gauntlets",
		ring1="Rajas Ring",
		ring2="Rufescent Ring",
        back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
		waist="Fotia Belt",
		legs="Odyssean Cuisses",
		feet="Sulev. Leggings +2"}	

    sets.precast.WS['Sanguine Blade'] = {
		ammo="Hasty Pinion +1",
        head="Ighwa Cap",
		neck="Sanctity Necklace",
		ear1="Moldavite Earring",
		ear2="Hecate's Earring",
        body="Souveran Cuirass",
		hands="Caballarius Gauntlets",
		ring1="Aquasoul Ring",
		ring2="Aquasoul Ring",
        back="Toro Cape",
		waist="Caudata Belt",
		legs="Chevalier's Cuisses +1",
		feet="Carmine Greaves"}
    
    sets.precast.WS['Atonement'] = {
		ammo="Ginsen",
		head={ name="Odyssean Helm", augments={'Accuracy+27','Weapon skill damage +5%','DEX+6',}},
		body="Phorcys Korazin",
		hands={ name="Odyssean Gauntlets", augments={'Weapon skill damage +3%','VIT+8','Accuracy+11',}},
		legs={ name="Odyssean Cuisses", augments={'Pet: "Mag.Atk.Bns."+26','Pet: DEX+10','Weapon skill damage +5%','Accuracy+17 Attack+17',}},
		feet="Sulev. Leggings +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear="Digni. Earring",
		left_ring="Supershear Ring",
		right_ring="Apeile Ring +1",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}
		
	sets.precast.WS['Aeolian Edge'] = {
		ammo="Hasty Pinion +1",
        head="Jumalik Helm",
		neck="Sanctity Necklace",
		ear1="Moldavite Earring",
		ear2="Hecate's Earring",
        body="Jumalik Mail",
		hands="Founder's Gauntlets",
		ring1="Acumen Ring",
		ring2="K'ayres Ring",
        back="Rudianos's Mantle",
		waist="Fotia Belt",
		legs="Eschite Cuisses",
		feet="Founder's Greaves"}	
    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
		ammo="Incantor Stone",
        head="Carmine Mask",
		neck="Sanctity Necklace",
		body="Reverence Surcoat +2",
		hands="Leyline Gloves",
		ear1="Loquacious Earring",
		ear2="Etiolation Earring",
		ring1="K'ayres Ring",
		ring2="Meridian Ring",
		waist="Cetl Belt",
		back={ name="Rudianos's Mantle", augments={'HP+60','"Fast Cast"+10','Eva.+20 /Mag. Eva.+20',}},
		legs="Eschite Cuisses",
		feet={ name="Odyssean Greaves", augments={'Agi+4','"Mag. Acc."+2','"Mag.Atk.Bns"+6','"Fast Cast"+6',}},}
        
	sets.midcast['Flash'] = sets.enmity    
    sets.midcast.Stun = sets.midcast.Flash
    
    sets.midcast.Cure = {
		ammo="Staunch Tathlum",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body={ name="Jumalik Mail", augments={'HP+25','Enmity+3',}},
		hands="Macabre Gaunt. +1",
		legs="Souveran Diechlings +1",
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Incanter's Torque",
		waist="Asklepian Belt",
		left_ear="Mendi. Earring",
		right_ear="Nourish. Earring +1",
		left_ring="Meridian Ring",
		right_ring="Sirona's Ring",
		back="Solemnity Cape",
	}
		
	sets.self_healing = {
		ammo="Staunch Tathlum",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body={ name="Jumalik Mail", augments={'HP+25','Enmity+3',}},
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs="Souveran Diechlings +1",
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Incanter's Torque",
		waist="Gishdubar Sash",
		left_ear="Etiolation Earring",
		right_ear="Nourish. Earring +1",
		left_ring="Meridian Ring",
		right_ring="Vocane Ring",
		back="Solemnity Cape",
	}
	
    sets.midcast['Enhancing Magic'] = {
		head="Carmine Mask",
		neck="Incanter's Torque",
		body="Shabti Cuirass",
		neck="Incanter's Torque",
		waist="Olympus Sash",
		legs="Carmine Cuisses +1"}
	
	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {
		ammo="Iron Gobbet",
		neck="Incanter's Torque",
		hands="Souv. Handschuhs +1",
        back="Weard Mantle",
		legs="Carmine Cuisses +1",
		feet="Souveran Schuhs +1"})
		
	sets.midcast.Reprisal = set_combine(sets.midcast['Enhancing Magic'], {
		ammo="Iron Gobbet",
        head="Souveran Schaller +1",
		neck="Sanctity Necklace",
		body="Reverence Surcoat +2",
		hands="Souv. Handschuhs +1",
		ring1="K'ayres Ring",
		ring2="Meridian Ring",
        back="Weard Mantle",
		waist="Creed Baudrier",
		legs="Souveran Diechlings +1",
		feet="Souveran Schuhs +1"})	
		
	sets.midcast['Divine Magic'] = {
		head="Jumalik Helm",
		neck="Incanter's Torque",
		ear1="Beatific Earring",
		ear2="Knight's Earring",
		body="Rev. Surcoat +2",
		hands="Eschite Gauntlets",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Altruistic Cape",
		waist="Asklepian Belt",
		legs="Kaiser Diechlings",
		feet="Templar Sabatons"}	
		
	sets.midcast.Holy = {
		head="Jumalik Helm",
		body="Jumalik Mail",
		hands="Leyline Gloves",
		neck="Sanctity Necklace",
		ear1="Moldavite Earring",
		ear2="Hecate's Earring",
		ring1="Acumen Ring",
		waist="Asklepian Belt",
		back="Izdubar Mantle",
		legs="Eschite Cuisses",
		feet="Founder's Greaves"}
		
	sets.midcast.Banish = sets.midcast.Holy	
    
    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
    
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
    
    sets.resting = {neck="Creed Collar",
        ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt"}
    

    -- Idle sets
    sets.idle = {
		ammo="Homiliary",
        head="Souveran Schaller +1",
		neck="Coatl Gorget +1",
		ear1="Genmei Earring",
		ear2="Etiolation Earring",
        body="Souveran Cuirass",
		hands="Souveran Handschuhs +1",
		ring1="Defending Ring",
		ring2="Vocane Ring",
        back="Shadow Mantle",
		waist="Flume Belt +1",
		legs="Carmine Cuisses +1",
		feet="Souveran Schuhs +1"}

    sets.idle.Town = {
		ammo="Homiliary",
        head="Souveran Schaller +1",
		neck="Coatl Gorget +1",
		ear1="Genmei Earring",
		ear2="Etiolation Earring",
        body="Souveran Cuirass",
		hands="Souveran Handschuhs +1",
		ring1="Defending Ring",
		ring2="Vocane Ring",
        back="Shadow Mantle",
		waist="Flume Belt +1",
		legs="Carmine Cuisses +1",
		feet="Souveran Schuhs +1"}
    
    sets.idle.Weak = {
		ammo="Homiliary",
        head="Souveran Schaller +1",
		neck="Coatl Gorget +1",
		ear1="Genmei Earring",
		ear2="Etiolation Earring",
        body="Souveran Cuirass",
		hands="Souveran Handschuhs +1",
		ring1="Defending Ring",
		ring2="Vocane Ring",
        back="Shadow Mantle",
		waist="Flume Belt +1",
		legs="Carmine Cuisses +1",
		feet="Souveran Schuhs +1"}
    
    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
    
    sets.Kiting = {legs="Carmine Cuisses +1"}

    sets.latent_refresh = {waist="Fucho-no-obi"}


    --------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {back="Repulse Mantle"}
    sets.MP = {neck="Creed Collar",waist="Flume Belt"}
    sets.MP_Knockback = {neck="Creed Collar",waist="Flume Belt",back="Repulse Mantle"}
    
    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
    -- when activating or changing defense mode:
    sets.PhysicalShield = {main="Anahera Sword",sub="Killedar Shield"} -- Ochain
    sets.MagicalShield = {main="Anahera Sword",sub="Beatific Shield +1"} -- Aegis

    -- Basic defense sets.
        
    sets.defense.PDT = {
		ammo="Staunch Tathlum",
        head="Souveran Schaller +1",
		neck="Loricate Torque +1",
		ear1="Thureous Earring",
		ear2="Etiolation Earring",
        body="Reverence Surcoat +2",
		hands="Souveran Handschuhs +1",
		ring1="Defending Ring",
		ring2="Vocane Ring",
        back="Philidor Mantle",
		waist="Flume Belt +1",
		legs="Chevalier's Cuisses +1",
		feet="Souveran Schuhs +1"}
    sets.defense.BDT = {
		ammo="Staunch Tathlum",
        head="Souveran Schaller +1",
		neck="Loricate Torque +1",
		ear1="Thureous Earring",
		ear2="Etiolation Earring",
        body="Reverence Surcoat +2",
		hands="Sulevia's Gauntlets +1",
		ring1="Defending Ring",
		ring2="Vocane Ring",
        back="Philidor Mantle",
		waist="Nierenschutz",
		legs="Scuff. Cosciales",
		feet="Amm Greaves"}
    sets.defense.Reraise = {
		ammo="Staunch Tathlum",
        head="Twilight Helm",
		neck="Loricate Torque +1",
		ear1="Thureous Earring",
		ear2="Etiolation Earring",
        body="Twilight Mail",
		hands="Souveran Handschuhs +1",
		ring1="Defending Ring",
		ring2="Vocane Ring",
        back="Philidor Mantle",
		waist="Flume Belt +1",
		legs="Souveran Diechlings +1",
		feet="Souveran Schuhs +1"}
    sets.defense.Charm = {ammo="Iron Gobbet",
        head="Reverence Coronet +1",neck="Lavalier +1",ear1="Creed Earring",ear2="Buckler Earring",
        body="Reverence Surcoat +1",hands="Reverence Gauntlets +1",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Shadow Mantle",waist="Flume Belt",legs="Reverence Breeches +1",feet="Reverence Leggings +1"}
    -- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    sets.defense.MDT = {
		ammo="Demonry Stone",
        head="Founder's Corona",
		neck="Loricate Torque +1",
		ear1="Bladeborn Earring",
		ear2="Etiolation Earring",
        body="Reverence Surcoat +2",
		hands="Souveran Handschuhs +1",
		ring1="Defending Ring",
		ring2="Shadow Ring",
        back="Engulfer Cape +1",
		waist="Creed Baudrier",
		legs="Souveran Diechlings +1",
		feet="Amm Greaves"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    sets.engaged = {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body={ name="Acro Surcoat", augments={'Accuracy+18 Attack+18','"Dbl.Atk."+2',}},
		hands={ name="Emicho Gauntlets", augments={'HP+50','DEX+10','Accuracy+15',}},
		legs={ name="Odyssean Cuisses", augments={'Accuracy+19 Attack+19','"Store TP"+7','AGI+11','Accuracy+4','Attack+13',}},
		feet="Flam. Gambieras +2",
		neck="Asperity Necklace",
		waist="Sailfi Belt +1",
		left_ear="Brutal Earring",
		right_ear="Digni. Earring",
		left_ring="Rajas Ring",
		right_ring="Petrov Ring",
		back="Atheling Mantle",}

    sets.engaged.DW = {}

    sets.engaged.PDT = set_combine(sets.engaged, {})
    sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)

    sets.engaged.DW.PDT = set_combine(sets.engaged.DW, {})
    sets.engaged.DW.Reraise = set_combine(sets.engaged.DW, sets.Reraise)
 

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Doom = {head="Twilight Helm", body="Twilight Mail"}
    sets.buff.Cover = {head="Reverence Coronet +1", body="Caballarius Surcoat +1"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
        handle_equipping_gear(player.status)
        eventArgs.handled = false
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)
    if state.EquipShield.value == true then
        classes.CustomDefenseGroups:append(state.DefenseMode.current .. 'Shield')
    end

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_defense_mode()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    
    return meleeSet
end

function customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end
    
    if state.EquipShield.value == true then
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end
    
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end
    
    return defenseSet
end


function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    if state.ExtraDefenseMode.value ~= 'None' then
        msg = msg .. ', Extra: ' .. state.ExtraDefenseMode.value
    end
    
    if state.EquipShield.value == true then
        msg = msg .. ', Force Equip Shield'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_defense_mode()
    if player.equipment.main == 'Kheshig Blade' and not classes.CustomDefenseGroups:contains('Kheshig Blade') then
        classes.CustomDefenseGroups:append('Kheshig Blade')
    end
    
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 3)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 3)
    elseif player.sub_job == 'RDM' then
        set_macro_page(1, 3)
    else
        set_macro_page(1, 3)
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
  if spellMap == 'Cure' and spell.target.type == 'SELF' and sets.self_healing then
            equip(sets.self_healing)
    end
end