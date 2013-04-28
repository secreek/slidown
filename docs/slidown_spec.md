# Slidown Specs
*draft*
## Vision Spec

Slidown enables users to quickly create slideshows for presentations to a small group of people or remote audiences. A user builds a slide show by composing a Markdown-like document, while focuses on content without taking layout and rendering into consideration. Slidown is not designed to be a replacement for transitional PowerPoint nor Keynote, instead people would feel convenient to use Slidown for lightweight slideshows and everyday discussions. Using Slidown might develop into an alternative expression form to email and blogging.

## Slidown Feature Spec

### Conference Room ☠
- Create a Presentation Event by Reserving a Conference Room
- A Welcome Screen with QR Code and Short URL
- Audience's Screen Automatically Follows Presenter's Screen
- Optional Interactions such as Chat, QA 

### Composing in Markdown ☠
- Online Editor with Live Preview
- Cross-platform Desktop Editor
- Live Preview
- Templates

### Interoperabilities
- Upload from Web, External Links Including Git Repo
- Import from Markdown, PPT, Keynote
- Export to PDF, Mindmap

### Integrations
- OpenID
- Service Hooks
- BlahTime

### Presenting
- Tree-walking ☠
- Outline View / Thumbnails View / Current + Next Slide View
- Private Notes
- HUD / Time / Schedule
- Optional Offline Players (Desktop / Mobile Apps)

### Audience Controls
- Optional control to Slide Back
- Starring / Bookmarking
- Confirm to Advance
- Export to PDF

### Effects
- Basic Transitions
- Background Music

### Publishing and Hosting
- Hosting Service for Slides and Associated Media Files
- Share it or Publish it
- Follow Others like those on Github and Twitter
- Feature Selected Slides on Front Page

### Organization
- Permission to view individual slides
- Permission to join a conference
- Permission to redirect to next presenter
- Managed with groups

### Customizability
- Theme
- Logo
- Font

## Slidown Tech Spec

### Slide Elements

#### Static
- Slogan
- Picture
- List
- Text
- Code
- Table
- Chart

#### Embedded ⚒2
- Web Page
- Youtube

#### Interactive ⚒3
- Form (for Reporting)
- Ballot (Voting)

### Basic Slidown Syntax
#### Slogan and Title
Any level of headings without **payload** (following content before next heading) are rendered as a slogan in screen center.

```
### Welcome to London
```

Any level of headings with payload are rendered as title, as payload rendered below it.

```
## Olympic Game 2012
![image](url)
```

#### Payloads

Just use standard Markdown syntax. Common type of payload:

- Image
- List
- Text
- Code
- Table
- Blockquote

Multiple / mixed blocks of payload are supported.

#### Inline Text Decoration

Use standard Markdown syntax for:
- Strong and Emphasize
- Inline Code
- Links

### Extended Slidown Syntax
#### Meta Data
Store / parse meta data at the very beginning of the document inside an HTML comment.

```<!---
theme: dark;
animation: slide-left;
-->
```

#### Hidden Title ⚒²
If the closing `#` exists, do not render title and use full screen space for payload content.

##### Normal Title:
```
# Hello
```
##### Hidden Title:
```
# Hello #
```

#### Highlight ⚒
Text enclosed by a pair of `#_` and `_#` **or ** a pair of `_#` and `#_` are converted to HTML 5 tag `<mark>` and `</mark>`.

```
Do not forget to buy #_milk_# today.
```

#### Speaker Note ⚒²

A pair of dual-slash `//` inclose a piece of speaker note. Render should convert the pair of marker to HTML tag `<dfn>` and `</dfn>`.

Speaker notes are removed by script before audience see the slide. *FIXME: Remove them on the sever side.*

```
// Do not show this line to the audiences //
```

#### Segments ⚒²

*FIXME: This causes horizontal line rendered visually*

A single slide can be divided into multiple stages by using segment symbol `- - - ` :

```
# Today's Meeting
## Topic 1
- - -
## Topic 2
```

**Note:** The horizontal line should not be rendered.

#### Sidebar ⚒3
Three pipes `|||` or `| | |` indicate a `Sidebar` or an HTML 5 `<aside>` tag, which will float the remaining content inside the heading scape to the right:

```
|||
Players:
- USA
- China
- Russia
- Japan
```

**Note:** A single slide may contain more than one side bar.

#### Chart ⚒4

Draw simple charts in HTML 5:

##### Simple Bar

Syntax:

```
=> Label1 Value1 <=> label2 Value2 ~~Type
```

Value must be an integer ranging from `0` to `100`.

Example:

```
=> China 65 <=> USA 72 <=> Russia 33 ~~Bar
```

The above Markdown should be translated to:

```
<div class="chart-bar">
	<div class="bar-65>China</div>
	<div class="bar-72>USA</div>
	<div class="bar-33>Russia</div>
</div>
```

Theme decides how to render the HTML visually.

##### Multi-segment-bar

*Note: Future document will explain this section*

```
# Olympic Medals
=> China 65:71:85 <=> USA 64:72:86 <=> Russia 63:73:87 ~~Bar
```

In this example, numbers are extracted for column height, and country names are extracted for column label. 

- A colon symbol `:` between numbers indicate a **multi-domain** record
- A plus symbol `+` between numbers indicate a **multi-segment** record

Chart Type may be:

- Bar
- Pie
- Histogram
- Line
- Table

### Rendering
#### General Rules
- Define a max-font-size, min-font-size for each element
- Always try using max-font-size first
- Decrease font size while content is too much to fit screen
- Allow scrolling when reaching min-font-size
- Allow scrolling when image size to too small
- Always leave white spaces at screen edges

#### Individual Element
##### Slogan
- A slogan is always placed at screen center
- Allow line wrapping

##### Title
- Title is placed on top
- No line-wrapping
- Allow line-wrapping in max 2 rows ⚒2
- Theme decides how to align text

##### Payloads
- Never use font large than that used by title

###### Image
- Never stretch
- If multiple payloads apply, reduce image size or scroll

###### Table and Chart
- Never horizontally scroll screen, no matter how small the font is

###### List
- Vertically align the list to the middle of screen
- Try moving horizontally the list to the center of screen while text is alway aligned left ⚒2

### Slide View (Web Page)
#### Main Content and Theme
- Spacebar / Single Mouse Click / Single Finger Swipe to Advance
- Optional Transitions
- Optional Background Music
- Light or Dark Themes

#### Toolbar
- Logo
- Tree-walking
- Presenter Provided Materials / Links
- Customized links

### Composer and Player UI

#### Web Site
- Uploading Button
- HTML 5 Drag-Drop Support ⚒2
- Fetching External URL (e.g. gist)
- Online Editor
- Online Editor with Live Preview
- Extra: Portal to Account Management

#### CLI (via API) ⚒2
*See API ref for details.*

```
$ sld new mydoc.md
$ vim mydoc.md
$ sld upload mydoc.md
$ sld list
$ sld play mydoc.md
```

#### Native GUI Composer
- Fork a Markdown Editor like *Mou.app*
- Import / Export
- Parse Clipboard for Rich Formatted Content (HTML, PDF)
- Upload Associated Media Files

#### General Composer UI Layout
- Top Toolbar
- Bottom Spanning Panel for Slide List
- Left Panel for Text Editor
- Right Panel for Preview of Current Rendering
- Separate Outline View and Slide View ⚒3

#### Desktop and Mobile Offline Player
- Sync Documents Offline to Play Later
- Encapsulate a Web control for Slide View
- Play Both Offline and Online

- - - 
*To be continued*
### Backend

#### User and Permissions
##### User
##### Organization
##### Permission

#### Interactive Features Support
##### Form
##### Voting

#### File Hosting

### API ⚒2
#### User
#### Organization
#### Document
#### Files

### Browser Support
- Modern Browsers Including IE9+, iOS6+, Android 4+
- Decent Layout on all Browsers since IE6
- IE8, iOS5, Android 2.x  ⚒³
