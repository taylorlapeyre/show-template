ShowTemplate = require '../lib/show-template'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "ShowTemplate", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('showTemplate')

  describe "when the show-template:toggle event is triggered", ->
    it "opens the template in a new tab", ->
      matching_line = "  template: 'templates/blah/thing'"
      atom.workspace.activePaneItem.buffer.lines.push matching_line

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'show-template:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspace.getPanes()[0].items.length).toBeGreaterThan(1)
