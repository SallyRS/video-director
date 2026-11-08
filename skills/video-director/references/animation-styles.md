# Animation styles

Ways of drawing or building the pictures in motion graphics and animation, grouped by how they are made. Use these as directions to consider, not presets. At stage 1b the user sees them as pictures and picks; at stage 4 each pick becomes a direction, drawn as still options for the same scene. Explain what each style adds to the idea. Follow the one-drawing-style and lead-medium rules in SKILL.md. Footage has no menu: its look is planned in the directions, with ideas from `footage-looks.md`.

## Stage 1b: suggesting styles

1. Pick 3-4 styles from the tables below that suit the film's subject, viewer and brand. They must:
   - be possible with the film's tools: a style **made with** clips needs the clip tool from the brief, or supplied footage (`media.md`, Without Higgsfield);
   - fit the people answer: no style marked in **Characters** for a faceless film;
   - look clearly different from each other, not three flat styles;
   - meet any condition in **Consider for** that starts with "Only when";
   - for a film that shows a software product, include Product interface when the product's screens are available (`types/product-launch.md`).
2. Build the page and give the user its path. It shows every style, with your suggestions on top, and copies the pictures next to it:

```bash
python3 <skill>/scripts/build_style_library.py --out references/styles-v1.html \
  --suggest "flat-vector=Clear for a process with many parts" --suggest "..." --suggest "..."
```

3. Recommend the 3-4 in one plain line each and ask: "Pick one or more to see as directions, describe the look you want in your own words, or say 'you choose'."
4. Record the picks in `brief.md`. A style the user names or describes counts as a pick.

## Stage 4: picks into directions

With one picked style, the directions keep it and differ in idea. With two or three, each style gets a direction. With more, recommend which three to draw first. When the reference videos showed the look, every direction uses that style. With "you choose", pick styles that fit the brief and the lead medium so the directions differ in style as well as idea. In a mix, match the footage's look to that direction's style (`footage-looks.md`).

## The columns

- **Made with**: *frames*, built in the frames from shapes, type and lines, with no generated media; *stills*, generated still images moved in the build, so it works without a clip tool; *clips*, generated clips that must keep one look across every shot (a clip tool), or supplied footage.
- **Characters**: *yes*, usually built around characters; *people*, needs real people on camera (or footage of them); — otherwise.

## The picture library

Every style has one example picture in `assets/style-library/`, linked in its row. Most show the same desk by a window with no people, so styles compare side by side; a style built around a character shows the same made-up creature, and the few that need a person each show a different one. `assets/style-library/index.html` shows them all by group. The pictures were made with image generation for this library, not taken from the example films; they show a look, not how it moves.

## How to use the examples

- **Example to study** names a well-known film, title sequence, music video or ad where the style can be seen. Use it to look the style up, or as a reference film when the user chose reference videos (`reference-films.md`). Check access before relying on it; record only what you actually inspected.
- Rows marked **Showcase 0:00** come from [Jesse Eisenbart's 20-style showcase](https://www.tiktok.com/@jesseeisenbart/video/7697657520793324818); the time locates the example. Those descriptions come from sampled stills, not verified motion recipes.
- The descriptions say what the style looks like, not how a source moved. Never infer movement, timing or construction from a still or a description. Design original motion with the bundled motion guidance; to reproduce a specific source movement, inspect that movement first, or offer original motion without claiming source fidelity.
- Selection cues are suggestions, not claims made by any source. Adapt the visual principle to the brief rather than copying the example's look.

## Motion design

| Style | What it looks like | Example to study | Consider for | Made with | Characters | Picture |
|---|---|---|---|---|---|---|
| Isometric | Objects and systems drawn at a fixed angle with no perspective, like small diagrams | *Monument Valley* (2014) | How a product or system fits together, platforms, logistics | frames | — | [picture](../assets/style-library/isometric.webp) |
| Line icons | Thin, even lines that draw themselves on, little or no fill | Apple's animated SF Symbols (2023) | Feature lists, steps, onboarding, short explainers | frames | — | [picture](../assets/style-library/line-icons.webp) |
| Shape morphing | Bold flat shapes that turn smoothly into one another | Google's logo animation (2015), dots turning into the G | Logo reveals, brand openers, one thing becoming another | frames | — | [picture](../assets/style-library/shape-morphing.webp) |
| Layered parallax | Flat drawings or photos split into layers that move at different depths | *The Kid Stays in the Picture* (2002) | Giving still pictures depth, history, photo stories | stills | — | [picture](../assets/style-library/layered-parallax.webp) |
| Abstract 3D | Clean, softly lit 3D shapes in a few colors | Microsoft's "Bloom" art for Windows 11 (2021) | Premium tech, hardware, launch openers | stills | — | [picture](../assets/style-library/abstract-3d.webp) |
| Soft 3D icons | Chubby, rounded 3D icons like soft clay or plastic | Microsoft's 3D Fluent emoji (2021) | Friendly app features, consumer tech, social ads | stills | — | [picture](../assets/style-library/soft-3d-icons.webp) |
| Photo cut-out mix | Cut-out photos with white edges, flat shapes and hand-drawn scribbles | FEVR's "Food Waste" film for WWF | Youthful brands, social ads, stories built from real photos | stills | — | [picture](../assets/style-library/photo-cut-out.webp) |
| Drawing over footage | Hand-drawn marks, arrows and circles on real video | The drawn sound effects in *Scott Pilgrim vs. the World* (2010) | Pointing things out in footage, how-tos, adding wit to product shots | clips | — | [picture](../assets/style-library/drawing-over-footage.webp) |
| Duotone | Photos printed in two brand colors | Spotify's duotone campaign photos (2015) | Brands with two strong colors, making mixed photos match | stills | — | [picture](../assets/style-library/duotone.webp) |
| Minimal mono | Black, white and gray with one accent color for what matters | *Pleasantville* (1998) | Serious or premium brands, pointing at one thing | frames | — | [picture](../assets/style-library/minimal-mono.webp) |
| Frosted glass | See-through frosted panels floating over a blurred picture | Apple's Liquid Glass interface (2025) | Only when the brand's product already uses glass panels; keep text readable | frames | — | [picture](../assets/style-library/frosted-glass.webp) |
| Soft gradient | Large soft color blends behind simple shapes | Stripe's moving homepage gradient | Only when the brand already uses gradients | frames | — | [picture](../assets/style-library/soft-gradient.webp) |
| Bento grid | The screen split into rounded boxes of different sizes, one idea per box | Apple's keynote summary slides | Only when the brand already uses bento layouts and the idea is "many"; every box moves | frames | — | [picture](../assets/style-library/bento-grid.webp) |

## Drawn and illustrated

| Style | What it looks like | Example to study | Consider for | Made with | Characters | Picture |
|---|---|---|---|---|---|---|
| Flat vector | Clean shapes, bold flat color, simple characters, no outlines | Kurzgesagt – In a Nutshell videos | Explainers, science, systems with many parts | frames | — | [picture](../assets/style-library/flat-vector.webp) |
| Soft rounded characters | Friendly blobby characters, warm palette, gentle shapes | Headspace's animated guides | Wellness, calm how-tos, reassuring products | frames | yes | [picture](../assets/style-library/soft-rounded-characters.webp) |
| Whiteboard | A hand draws black lines on white as the voice speaks | RSA Animate, "Changing Education Paradigms" (2010) | Talks, arguments, step-by-step reasoning | frames | — | [picture](../assets/style-library/whiteboard.webp) |
| Pencil sketch | Moving graphite drawings, visible strokes | a-ha, "Take On Me" (1985) | Ideas taking shape, a drawn world meeting a real one | stills | — | [picture](../assets/style-library/pencil-sketch.webp) |
| Rotoscope | Footage traced into drawn shapes | *A Scanner Darkly* (2006) | Real people with a dreamlike or private feel | clips | people | [picture](../assets/style-library/rotoscope.webp) |
| Watercolour | Soft-edged washes, paper texture | Showcase 0:04 | Tactile, gentle or illustrative storytelling | stills | — | [picture](../assets/style-library/watercolour.webp) |
| Painterly oil | Every frame a painting, visible brushwork | *Loving Vincent* (2017) | Art, heritage, emotional brand stories | stills | — | [picture](../assets/style-library/painterly-oil.webp) |
| Comic book | Halftone dots, outlines, panels, printed-color offsets | *Spider-Man: Into the Spider-Verse* (2018) | Energy, youth, action, a hero's moment | stills | — | [picture](../assets/style-library/comic-book.webp) |
| Anime cel | Clean outlines, painted backgrounds, expressive faces | *Spirited Away* (2001) | Story-led films, characters, wonder | stills | yes | [picture](../assets/style-library/anime-cel.webp) |
| Mid-century graphic | Flat shapes, limited motion, bold color, paper textures | End credits of *The Incredibles* (2004); UPA's *Gerald McBoing-Boing* (1950) | Retro charm, playful brand stories | frames | — | [picture](../assets/style-library/mid-century-graphic.webp) |
| Silhouette | Black cut-out figures against colored light | Lotte Reiniger, *The Adventures of Prince Achmed* (1926) | Fables, origin stories, simple strong outlines | frames | — | [picture](../assets/style-library/silhouette.webp) |
| Psychedelic | Saturated wavy bands, bold lettering | Showcase 0:03; *Yellow Submarine* (1968) | Surreal, expressive or music-led moments | stills | — | [picture](../assets/style-library/psychedelic.webp) |
| Hand drawn over 3D | Line drawing with the weight of a 3D scene | Disney, *Paperman* (2012) | Romance, warmth, a crafted feel with depth | stills | — | [picture](../assets/style-library/hand-drawn-over-3d.webp) |

## Paper, craft and physical

| Style | What it looks like | Example to study | Consider for | Made with | Characters | Picture |
|---|---|---|---|---|---|---|
| Clay stop motion | Modeled clay figures, visible thumbprints, small jumps between frames | Aardman, *Wallace & Gromit* | Warm comedy, handmade products | clips | yes | [picture](../assets/style-library/clay-stop-motion.webp) |
| Puppet stop motion | Detailed puppets and miniature sets | *Coraline* (2009); *Fantastic Mr. Fox* (2009) | Storybook worlds, craft, gentle strangeness | clips | yes | [picture](../assets/style-library/puppet-stop-motion.webp) |
| Object stop motion | Everyday objects moved frame by frame to become something else | PES, *Western Spaghetti* (2008) | Food, making things, clever substitutions | clips | — | [picture](../assets/style-library/object-stop-motion.webp) |
| Pixilation | Real people moved frame by frame like puppets | Norman McLaren, *Neighbours* (1952) | Odd, comic or impossible human movement | clips | people | [picture](../assets/style-library/pixilation.webp) |
| Cut paper | Flat paper pieces moved on a table | Terry Gilliam's *Monty Python* animations | Comedy, satire, collage-like stories | stills | — | [picture](../assets/style-library/cut-paper.webp) |
| Collage | Overlapping newspaper, patterned paper and photo fragments | Showcase 0:15 | Combining sources, memories or disparate ideas | stills | — | [picture](../assets/style-library/collage.webp) |
| Origami | Angular folded-paper forms | Showcase 0:07 | Folding, assembly or transformation | stills | — | [picture](../assets/style-library/origami.webp) |
| Sand | Pictures drawn and wiped in sand on lit glass | Caroline Leaf, *The Owl Who Married a Goose* (1974) | Memory, flowing change from one picture to the next | stills | — | [picture](../assets/style-library/sand.webp) |

## Graphic and type-led

| Style | What it looks like | Example to study | Consider for | Made with | Characters | Picture |
|---|---|---|---|---|---|---|
| Product interface | The product's real screens rebuilt in clean vector shapes, cropped close, on flat brand color | Launch films for Notion AI, Superhuman or Granola | Software launches, showing what a feature does | frames | — | [picture](../assets/style-library/product-interface.webp) |
| Kinetic typography | Words move, scale and cut to the beat as the main picture | Prince, "Sign o' the Times" (1987) | Lyrics, quotes, claims, films with few pictures | frames | — | [picture](../assets/style-library/kinetic-typography.webp) |
| Modernist grid | Lines and type sliding on a strict grid | Saul Bass, *North by Northwest* titles (1959) | Order, precision, architecture, finance | frames | — | [picture](../assets/style-library/modernist-grid.webp) |
| Cut-out graphic | Flat paper-like shapes and type, jagged and bold | Saul Bass, *Anatomy of a Murder* titles (1959) | Bold brand openers, drama, mystery | frames | — | [picture](../assets/style-library/cut-out-graphic.webp) |
| Distressed type | Scratched, hand-made, jittering type and film damage | Kyle Cooper, *Se7en* titles (1995) | Tension, obsession, thrillers | frames | — | [picture](../assets/style-library/distressed-type.webp) |
| Data story | Moving charts as the main picture, a person explaining | Hans Rosling, "200 Countries, 200 Years, 4 Minutes" (BBC, 2010) | Numbers that change over time, reports, recaps | frames | — | [picture](../assets/style-library/data-story.webp) |
| Memphis | Bright geometric shapes, dots, zigzags and squiggles | Showcase 0:10 | Playful, energetic abstraction | frames | — | [picture](../assets/style-library/memphis.webp) |
| Op art | Black-and-white curved stripes form an optical pattern | Showcase 0:21 | Perception, contrast or a controlled visual illusion | frames | — | [picture](../assets/style-library/op-art.webp) |
| Word art | Arched, dimensional, multicolor lettering | Showcase 0:14–15 | Retro computer nostalgia or a short expressive title | frames | — | [picture](../assets/style-library/word-art.webp) |
| Teletext | Blocky colored text and pixel graphics on black | Showcase 0:06 | Broadcast-era information, headlines or retro data | frames | — | [picture](../assets/style-library/teletext.webp) |
| Web 1.0 | Early web page, starry background, colored links | Showcase 0:00 | Internet nostalgia, intentionally amateur interfaces | frames | — | [picture](../assets/style-library/web-1-0.webp) |
| Retro desktop | Old desktop windows and stacked error dialogs | Showcase 0:26–27 | Period computing or interface history | frames | — | [picture](../assets/style-library/retro-desktop.webp) |
| Pixel art | Low-resolution sprites, game-style effects | Video-game moments in *Scott Pilgrim vs. the World* (2010) | Games, nostalgia, playful scores and levels | stills | — | [picture](../assets/style-library/pixel-art.webp) |
| 1-bit dither | Black-and-white dotted images in a retro window | Showcase 0:23–24 | Limited-palette digital texture or archival computing | frames | — | [picture](../assets/style-library/1-bit-dither.webp) |
| Neon grid | Glowing lines on black, a vector world | *Tron* (1982) | Retro-future, speed, the inside of a computer | frames | — | [picture](../assets/style-library/neon-grid.webp) |
| Datamosh | Picture breaks into horizontally displaced blocks | Showcase 0:16–17 | Disruption or a deliberately digital transition | frames | — | [picture](../assets/style-library/datamosh.webp) |

## 3D and texture

| Style | What it looks like | Example to study | Consider for | Made with | Characters | Picture |
|---|---|---|---|---|---|---|
| Character 3D | Rounded, lit 3D characters and sets | *Toy Story* (1995) | Characters, family audiences, warm stories | clips | yes | [picture](../assets/style-library/character-3d.webp) |
| Painterly 3D | 3D shapes with painted textures and drawn effects | *Arcane* (2021) | Premium drama, games, a crafted feel | stills | — | [picture](../assets/style-library/painterly-3d.webp) |
| Skeuomorphic | Physical-looking meters, knobs and switches | Showcase 0:25 | Tangible controls or material metaphors | stills | — | [picture](../assets/style-library/skeuomorphic.webp) |
| Neumorphism | Pale interface controls with soft raised and inset shading | Showcase 0:12–13 | Soft tactile interface concepts; keep contrast readable | frames | — | [picture](../assets/style-library/neumorphism.webp) |
| Topographic | Contour lines, elevation markers, dotted routes | Showcase 0:02 | Journeys, terrain, layers or mapping a path | frames | — | [picture](../assets/style-library/topographic.webp) |
| Flow field | Fine colored strands curving across a dark field | Showcase 0:11 | Direction, currents or complex systems | frames | — | [picture](../assets/style-library/flow-field.webp) |
| Spirograph | Fine overlapping loops form a radial pattern | Showcase 0:18 | Cycles, repetition or intricate systems | frames | — | [picture](../assets/style-library/spirograph.webp) |

## Fit and constraints

Apply the house rules, including no gradient text or logo glow, unless the user explicitly overrides them. Frosted glass, Soft gradient and Bento grid break the house rules unless the brand already uses that look, so their rows say "Only when". For Word art, use dimensional or arched lettering in permitted solid colors. Neon grid lines are illustrative objects; they do not authorize glowing logos or glowing text. Where a type file explicitly offers an exception, follow its approval requirement. A note you author in the storyboard alone grants no exception. An explicit user instruction can override a skill rule; record that instruction and preserve its scope without implying broader permission.

Stop-motion, clay and paper looks made with generated media must hold one consistent look across every shot; check that before choosing them. Retro interfaces are illustrative unless they match the real product. Keep text readable and test op-art, dither, glitch, flicker-prone and fast-changing styles for legibility in the actual render. Never name a direction after a film, director or company; name the style. Define moves with the bundled motion library and motion spec after still approval.
