# Generated clips: planning shots that work

What to plan before generating clips of people and physical products, so fewer clips are remade. Read sections 1-3 at stage 6, before counting clips for the cost estimate (a split shot is two clips), and again before writing each clip prompt. Read section 4 when a clip keeps failing.

Adapted from [DirectorSKILL](https://github.com/wuwangzhang1216/DirectorSKILL) by wangzhang-wu (MIT). Its numbers are planning estimates, not measurements: treat them as starting values, and record in the build log what happened on the film.

## 1. Actions clip models get wrong

A better prompt rarely fixes these. Plan the replacement before writing the prompt.

| Action | Plan this instead |
|---|---|
| A hand working something: keys, buttons, writing, a pour | Cut before the hand touches it; or a short insert, under about 1.5 s of contact, with the hand entering already in position; or show the finished result and let the sound and the face tell it |
| Handing an object to someone | Two clips: the reach, then the object already in the other hand. The cut does the handover |
| Two people touching: a handshake, a hug | One clip per person, joined on the cut at the moment of contact |
| Sitting down | Start the clip already seated and let the body settle |
| Standing up | Hands stay on the knees, never on the chair |
| Leaving the frame and coming back | Exit only. The return is a new clip from a new start still |
| Turning all the way round | Turn about 90° at most |
| Stairs; running with the camera following | Two fixed shots (top and bottom of the stairs); or a fixed wide with the person crossing the frame |
| A prop that goes behind something and comes back | Keep it in frame for the whole clip, 5 s or less; or make the reveal a cut |
| Mirrors and reflections | Show only the reflection, or break the surface (steam, rain, a dark mirror) |
| Faces in a crowd | Silhouettes, backs of heads or out of focus; at most two clear faces |
| An exact count ("seven candles") | One, two or many. A number that matters goes in a line or a designed insert |

These work well: breathing, a head turn under about 45°, lowering or lifting the head, a hand rising without touching anything, two or three slow steps toward the camera. Ask for breathing in every person clip; without it a clip looks like a still.

**Split a hard shot before generating.** A shot with contact (a hand on an object, two people touching, an object pushed into a slot or against a door) plus one other hard thing (a clip over about 5 s, a camera move, a second person, a prop that must stay exact) becomes two clips. Clip A ends at the moment the outcome is certain (the latch releasing), still moving; clip B starts just after, already moving, from another angle (section 2). The hand or arm stays visible on the object in clip B, so nothing moves without a cause.

A shot held for a beat (the product turn's 2 s in `types/live-action-story.md`) can still be held: the hold is the shot, and only the contact inside it is kept short.

## 2. Cuts between generated shots

A clip model knows nothing about the shot before or after. Write these into every start still and prompt:

- **Sides of the frame.** For each scene, decide which side of the frame each person is on and which way they look and travel. Name it in every start still ("she is in the left third, looking right"). Keep it for the whole scene unless a shot shows them crossing.
- **A cut between two clips of the same subject changes enough.** Move the camera at least about 30° around the subject, or change the shot size by two steps (wide to close-up, not medium to medium close-up). Describe the new angle by what is visible ("from her other side; the window is now behind her left shoulder"). A smaller change looks like a glitch. The one exception is a run of long takes from one fixed camera, cut on the person's movement (`types/live-action-story.md`, Motion and transitions): those jumps are intended.
- **Light from one place.** Write one line per scene saying where the light is in the room ("the only window is on the left wall; soft late-morning light"), and paste it word for word into every prompt of that scene. Add one line per shot saying where it falls for this camera ("the light comes from camera left; her nose shadow falls on her right cheek"). In a close-up the source is out of frame, so name it and one visible effect of it, or the model falls back to flat front light.
- **Cut while something moves.** A cut near the fastest point of a movement hides small differences; a cut between two still frames shows them.
- **Trim the ends.** A clip settles in its first third of a second and drifts in its last half second. Generate about 1 s longer than the shot needs (count that second in the stage 6 cost estimate), and cut those ends off before judging the clip. A first-and-last-frame clip is the exception: its ends are the approved stills.

## 3. Continuity before generating

The continuity sheets in `build-and-qa.md` find changes after the render. These stop most of them before.

- **The empty room first.** For each place, generate the empty room at its widest angle and show it with the stage 6 storyboard for approval. Make every other still of that place by editing that image (add the person, change the angle), never from a new prompt; the edit brief is in `assets/codex-image-brief.md`. In the edit, name the light on the person, where their feet or hands touch, and what they hide.
- **What changes, shot by shot.** When writing `build/continuity.json` at stage 6, put the item's state in each shot's `label` ("hallway, door shut", "desk, bottle in her right hand"). When the state changes partway through a shot, add a second entry at the moment it changes. A shot starts in the state the shot before it ended in, and a scene's last state is the next scene's first.
- **The character description.** One description per person, written at stage 6 and pasted word for word into every still brief and clip prompt that shows them. In this order: age, gender, ethnicity and build; two or three face facts (jaw, eyes, brow, nose); exactly one mark you can check at a glance (a mole on her left cheek, a chipped front tooth); hair length, cut and parting side; then what they wear in this scene, every piece the camera sees, with any change from earlier scenes (a shirt pulled on in scene 4 stays on after it). The mark is the quickest way to see that a face has changed.
- **An end frame for a person or product clip is an edit of its start frame.** When such a clip needs an end frame, make it by editing the approved start frame ("keep everything identical; change only this: her head lifts and turns to the window"), never as a new image. A new image changes many small things, and the clip morphs between them. If more than one thing changes (one body part, one object, one light), it is two shots. A clip that joins a designed scene is different: its last frame is that scene's frame (`media.md`, Prompting clips).

## 4. When a clip keeps failing

First turn the note into something you can see in the frames:

- **"Looks fake"**: no weight (a body or object lands without impact), floaty speed, light that moves, or only the face moving.
- **"Looks like AI"**: shapes melting or limbs merging, then hands, eyes or teeth, then rubbery speed.
- **"Looks cheap"**: the speed, then flat or shifting light.
- **"Boring"**: not a generation problem. Re-plan the shot or cut it.

Then fix it, starting with what costs nothing: trim or cut around the problem in the edit. Within the shot's budget (two to three generations, or the figure in the brief), change the prompt or remake the start still. Generate again unchanged at most once.

After three failed generations, or "looks fake" twice, stop generating that shot. Propose 2-3 different shots as stills beside the current frame (`polish-rounds.md`, section 2), recommend one, and wait for the user. Re-plan without waiting for a third try when the shot needs something from the table in section 1. A different shot means one of: half the length; one or two sizes closer; one movement only, camera fixed; two clips with a cut; a reaction shot instead of the action; the action off screen and only its result shown; or a designed frame. If any fix would go past the stage 6 cost estimate, give the new figure and ask first.

## 5. Physical products

- **The product stays still and so does the camera; the light moves.** A soft light travels across the product. The picture moves, and the model never has to redraw the product from a new angle.
- **Where the logo, color or shape must be exact, use the real product, laid over in the build.** The hero shot, the packshot, any shot showing the logo: generate the room and the light without the product, then place the brand's own product image (or a simple photo of it) over that clip in HyperFrames, with the light's movement and the shadow added there. Generated media still never draws the logo (`media.md`). Match the product's real color; never accept a generated color as final.
- **A hand using the product** gets its own clip: it enters already in position, touches for under about 1.5 s, and the contact falls on the cut. Filming it is better.
- **Pours, hinges, lids, clasps**: two states either side of a cut (the bottle tilting, then the full glass), never one continuous movement.
- **Fine to generate**: rooms, surfaces, steam, dust, close texture with no logo in frame, and a face reacting with the product out of frame.

## 6. Two people talking

- One speaking face per clip, unless the user says the clip tool syncs two speakers or a test clip shows both mouths in sync.
- For each person, make a speaking clip and a listening clip at the same size, lens and light, looking toward the other person's side of the frame (section 2). Make the listening clips long: they are trimmed to fit and have no lip-sync risk.
- A line spoken on camera with lip sync is about 6 words or fewer, in a medium close-up or tighter, in a clip of about 4 s. A longer line plays off screen over the other person listening.
- Overlaps and interruptions are made in the edit: start the next person's audio a little before the picture cut.
- Before any of this, ask whether the line could be a look instead.
