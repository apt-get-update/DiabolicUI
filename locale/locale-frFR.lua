local _, Engine = ...

local L = Engine:NewLocale("frFR")
if not L then
	return
end

-- actionbar module
---------------------------------------------------------------------

-- keybinds
L["Alt"] = "A"
L["Ctrl"] = "C"
L["Shift"] = "S"
L["NumPad"] = "N"
L["Backspace"] = "BS"
L["Button1"] = "B1"
L["Button2"] = "B2"
L["Button3"] = "B3"
L["Button4"] = "B4"
L["Button5"] = "B5"
L["Button6"] = "B6"
L["Button7"] = "B7"
L["Button8"] = "B8"
L["Button9"] = "B9"
L["Button10"] = "B10"
L["Button11"] = "B11"
L["Button12"] = "B12"
L["Button13"] = "B13"
L["Button14"] = "B14"
L["Button15"] = "B15"
L["Button16"] = "B16"
L["Button17"] = "B17"
L["Button18"] = "B18"
L["Button19"] = "B19"
L["Button20"] = "B20"
L["Button21"] = "B21"
L["Button22"] = "B22"
L["Button23"] = "B23"
L["Button24"] = "B24"
L["Button25"] = "B25"
L["Button26"] = "B26"
L["Button27"] = "B27"
L["Button28"] = "B28"
L["Button29"] = "B29"
L["Button30"] = "B30"
L["Button31"] = "B31"
L["Capslock"] = "Cp"
L["Clear"] = "Cl"
L["Delete"] = "Del"
L["End"] = "En"
L["Home"] = "HM"
L["Insert"] = "Ins"
L["Mouse Wheel Down"] = "WD"
L["Mouse Wheel Up"] = "WU"
L["Num Lock"] = "NL"
L["Page Down"] = "PD"
L["Page Up"] = "PU"
L["Scroll Lock"] = "SL"
L["Spacebar"] = "Sp"
L["Tab"] = "Tb"
L["Down Arrow"] = "BA"
L["Left Arrow"] = "GA"
L["Right Arrow"] = "DA"
L["Up Arrow"] = "HA"

-- floating buttons
L["Request Stop"] = "Demander l'arrêt"
L["<Left-click> to land at the next flight point."] = "<Clic gauche> pour atterrir au prochain point de vol."

-- item tooltips
L["Equipped"] = "Équipé"

-- minimap

-- unitframe module
L["Class-Colored Health"] = "Vie aux couleurs de classe"
L["Health bars in class colors.|n|nNeeds a reload. Preview: /dui party, /dui raid"] =
	"Barres de vie aux couleurs de classe.|n|nNécessite un rechargement. Aperçu : /dui party, /dui raid"
L["3D Portraits"] = "Portraits 3D"
L["3D portraits on the party and focus frames.|n|nNeeds a reload."] =
	"Portraits 3D sur les cadres de groupe et de focalisation.|n|nNécessite un rechargement."
L["Menu"] = "Menu"
L["Show Gold"] = "Afficher l'argent"
L["Your gold next to the menu button."] = "Votre or à côté du bouton du menu."
L["Objectives"] = "Objectifs"
L["Diablo III Windows"] = "Fenêtres Diablo III"
L["Show unassigned spells"] = "Sorts non assignés"
L["Rings the spells you can cast that are on none of your action bars."] =
	"Entoure les sorts lançables qui ne sont sur aucune de vos barres d'action."
L["Unassigned"] = "Non assignés"
L["All ranks"] = "Tous les rangs"
L["No spell found"] = "Aucun sort trouvé"
L["Apprentice"] = "Apprenti"
L["Journeyman"] = "Compagnon"
L["Expert"] = "Expert"
L["Artisan"] = "Artisan"
L["Master"] = "Maître"
L["Grand Master"] = "Grand maître"
L["Herbalism"] = "Herboristerie"
L["Missing Primary Profession"] = "Métier principal manquant"
L["Visit a profession trainer in a capital city to learn one."] =
	"Rendez-vous chez un maître de métier dans une capitale pour en apprendre un."
L["Not learned yet: visit its trainer to learn it."] =
	"Pas encore appris : rendez-vous chez son maître pour l'apprendre."
L["Blizzard's windows (character, bags, loot...) in the Diablo III style.|n|nNeeds a reload."] =
	"Les fenêtres de Blizzard (personnage, sacs, butin...) dans le style de Diablo III.|n|nNécessite un rechargement."
L["Master Loot Rolls"] = "Jets du maître du butin"
L["Coming Up"] = "À venir"
L["Fake Boss"] = "Faux boss"
L["A window to roll Main Spec or Off Spec when the master looter puts an item up.|n|nNeeds a reload. Preview: /dui loot"] =
	"Une fenêtre pour tirer Spé principale ou secondaire quand le maître du butin met un objet en jeu.|n|nNécessite un rechargement. Aperçu : /dui loot"
L["Main Spec"] = "Spé principale"
L["Off Spec"] = "Spé secondaire"
L["Pass"] = "Passer"
L["You passed"] = "Vous avez passé"
L["You rolled %d (%s)"] = "Vous avez fait %d (%s)"

-- tooltip module
L["Tooltips"] = "Infobulles"
L["Horizontal Offset"] = "Décalage horizontal"
L["Vertical Offset"] = "Décalage vertical"
L["At 0, the tooltip is centered horizontally on the cursor."] =
	"À 0, l'infobulle est centrée horizontalement sur le curseur."
L["At 0, the cursor is at the bottom edge of the tooltip."] =
	"À 0, le curseur se trouve sur le bord inférieur de l'infobulle."
L["Tooltip Anchor"] = "Ancrage de l'infobulle"
L["Interface"] = "Interface"
L["Minimap Anchor"] = "Ancrage de la minicarte"
L["The screen corner or edge the minimap snaps to."] = "Le coin ou le bord de l'écran où se place la minicarte."
L["Minimap Size"] = "Taille de la minicarte"
L["Also: right-drag the minimap while frames are unlocked."] =
	"Aussi : clic droit glissé sur la minicarte quand les cadres sont déverrouillés."
L["The point of the tooltip that sits on your cursor."] = "Le point de l'infobulle placé sur votre curseur."
L["Top Left"] = "Haut gauche"
L["Top"] = "Haut"
L["Top Right"] = "Haut droite"
L["Left"] = "Gauche"
L["Center"] = "Centre"
L["Right"] = "Droite"
L["Bottom Left"] = "Bas gauche"
L["Bottom"] = "Bas"
L["Bottom Right"] = "Bas droite"

-- chat module
L["General"] = "Général"
L["Click to copy the link."] = "Cliquez pour copier le lien."
L["Shorter Messages"] = "Messages plus courts"
L["Boss and zone names over the world, and your gold, XP and loot at the right."] =
	"Noms des boss et des zones à l'écran, et votre or, XP et butin à droite."
L["'Guild' becomes 'G', '2. Trade - City' becomes '2.'."] =
	"« Guilde » devient « G », « 2. Commerce - Ville » devient « 2. »."
L["Names and nameplates hidden out of combat. Enemy players' names stay, except in Dalaran and Shattrath."] =
	"Noms et barres d'info masqués hors combat. Les noms des joueurs ennemis restent, sauf à Dalaran et Shattrath."
L["The screen edges pulse red under 35% health.|n|nNeeds a reload."] =
	"Les bords de l'écran pulsent en rouge sous 35 % de vie.|n|nNécessite un rechargement."
L["The last 100 chat lines come back after a reload or relog."] =
	"Les 100 dernières lignes du chat reviennent après un rechargement ou une reconnexion."
L["Loot, XP, reputation and other system lines made short: '+ [Item] (3)'."] =
	"Butin, XP, réputation et autres lignes système en court : « + [Objet] (3) »."
L["Auctions"] = "Enchères"
L["Achievements"] = "Hauts faits"
L["Hide Channel Notices"] = "Masquer les canaux"
L["Hides channel join and leave notices, and empty lines."] =
	"Masque les avis d'entrée et de sortie des canaux, et les lignes vides."
L["Talent Specialization"] = "Spécialisation"
L["<Left-click> to switch"] = "<Clic gauche> pour changer"
L["Specializations"] = "Spécialisations"
L["Equipment set '%s' not found."] = "Ensemble d'équipement « %s » introuvable."
L["Active"] = "Active"
L["Learn Dual Talent Specialization to set this up."] = "Apprenez la double spécialisation pour configurer ceci."
L["Switching spec puts on its gear, action bars and macros."] =
	"Changer de spé met son équipement, ses barres et ses macros."
L["Equipment Set"] = "Ensemble d'équipement"
L["New Equipment Set"] = "Nouvel ensemble d'équipement"
L["Stats"] = "Statistiques"
L["Titles"] = "Titres"
L["Sets"] = "Ensembles"
L["The equipment set to put on."] = "L'ensemble d'équipement à mettre."
L["Save"] = "Enregistrer"
L["Restore"] = "Restaurer"
L["Your action bars as they are now become this specialization's."] =
	"Vos barres d'action telles qu'elles sont deviennent celles de cette spécialisation."
L["Puts this specialization's saved action bars back now."] =
	"Remet maintenant les barres d'action enregistrées de cette spécialisation."
L["Saved with Save, put back once you switch to it."] =
	"Enregistrées avec Enregistrer, remises quand vous passez à cette spécialisation."
L["Action bars saved for %s."] = "Barres d'action enregistrées pour %s."
L["No action bars saved for %s yet."] = "Aucune barre d'action enregistrée pour %s."
L["%s's action bars restored, %d buttons couldn't be found."] = "Barres de %s remises, %d boutons introuvables."
L["%s's action bars restored."] = "Barres de %s remises."
L["Action Bars"] = "Barres d'action"
L["Side Bars"] = "Barres latérales"
L["None"] = "Aucun"
L["<Left-click> to use %s."] = "<Clic gauche> pour utiliser %s."
L["Macro Before"] = "Macro avant"
L["A macro to run just before switching to this specialization."] =
	"Une macro à lancer juste avant de passer à cette spécialisation."
L["Macro After"] = "Macro après"
L["Runs your '%s' macro first"] = "Lance d'abord votre macro « %s »"
L["A macro to run after switching: the skull's button glows, click it again to run it."] =
	"Une macro à lancer après le changement : le bouton du crâne brille, recliquez pour la lancer."
L["<Left-click> to run your '%s' macro"] = "<Clic gauche> pour lancer votre macro « %s »"
L["Macro '%s' not found."] = "Macro « %s » introuvable."
L["Your %s commands are too long for a macro, make one yourself: %s"] =
	"Vos commandes %s sont trop longues pour une macro, créez-la vous-même : %s"
L["Your other commands are now the character macro '%s', run by a click on the skull after switching."] =
	"Vos autres commandes sont maintenant la macro de personnage « %s », lancée par un clic sur le crâne après le changement."
L["No free character macro slot for your %s commands, they're kept until there's one."] =
	"Plus de place pour une macro de personnage pour vos commandes %s, elles sont gardées jusqu'à ce qu'il y en ait."

-- AddOns page (other addons styled)
L["DiabolicUI: Questie has changed, its tracker is left as it is."] =
	"DiabolicUI : Questie a changé, son suivi de quêtes est laissé tel quel."
L["Drag to move the tracker"] = "Glissez pour déplacer le suivi"
L["Reset Positions"] = "Positions par défaut"
L["Puts the moved frames back in their places."] = "Remet les cadres déplacés à leur place."
L["Version %s"] = "Version %s"
L["<%s> to show FPS & latency."] = "<%s> pour afficher les IPS et la latence."
L["Positions"] = "Positions"
L["Unlock Frames"] = "Déverrouiller les cadres"
L["Lock Frames"] = "Verrouiller les cadres"
L["Drag the minimap, chat, menu buttons, quest tracker and TrinketMenu. Right-drag the minimap to resize it.|n|nAlso: /dui move"] =
	"Déplacez la minicarte, le chat, les boutons du menu, le suivi des quêtes et TrinketMenu. Clic droit glissé sur la minicarte pour la redimensionner.|n|nAussi : /dui move"
L["Drag the highlighted frames to move them. Right-drag the minimap to resize it."] =
	"Glissez les cadres mis en évidence pour les déplacer. Glissez la minicarte avec le clic droit pour la redimensionner."
L["You can't move frames in combat."] = "Impossible de déplacer les cadres en combat."
L["UI Scale"] = "Échelle de l'interface"
L["The size of DiabolicUI's bars, orbs and frames.|n|nAlso: /dui setscale 0.9"] =
	"La taille des barres, orbes et cadres de DiabolicUI.|n|nAussi : /dui setscale 0.9"
L["Zone & Loot Messages"] = "Messages de zone et de butin"
L["Hide Names Out of Combat"] = "Masquer les noms hors combat"
