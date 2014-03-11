module.exports =

  activate: (state) ->
    atom.workspaceView.command "show-template:show", => @showTemplate()

  deactivate: ->
    @showTemplateView.destroy()

  showTemplate: ->
    editor = atom.workspace.activePaneItem
    template = ""
    for line in editor.buffer.lines
      template = @findTemplate(line) if @findTemplate(line)

    if template
      atom.workspace.open(template)


  findTemplate: (paneText) ->
    templateString = paneText.match(/\s*template: ['"](.+)['"]/)?[1]
    if templateString
      "#{atom.project.getPath()}/app/assets/javascripts/#{templateString}.hbs"
    else
      false
