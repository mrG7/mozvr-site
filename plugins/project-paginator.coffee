
module.exports = (env, callback) ->
  ### project-paginator plugin. Defaults can be overridden in config.json
      e.g. "projects": {"perPage": 10} ###

  defaults =
    template: 'index.jade' # template that renders pages
    projects: 'projects' # directory containing contents to paginate
    first: 'index.html' # filename/url for first page
    filename: 'page/%d/index.html' # filename for rest of pages
    perPage: 2 # number of projects per page

  # assign defaults any option not set in the config file
  options = env.config.projectpaginator or {}
  for key, value of defaults
    options[key] ?= defaults[key]

  getProjects = (contents) ->
    # helper that returns a list of projects found in *contents*
    # note that each project is assumed to have its own directory in the projects directory
    projects = contents[options.projects]._.directories.map (item) -> item.index
    # skip projects that does not have a template associated
    projects = projects.filter (item) -> item.template isnt 'none'
    # sort project by date
    projects.sort (a, b) -> b.date - a.date
    return projects

  class ProjectPage extends env.plugins.Page
    ### A page has a number and a list of projects ###

    constructor: (@pageNum, @projects) ->

    getFilename: ->
      if @pageNum is 1
        options.first
      else
        options.filename.replace '%d', @pageNum

    getView: -> (env, locals, contents, templates, callback) ->
      # simple view to pass projects and pagenum to the project-paginator template
      # note that this function returns a funciton

      # get the project-pagination template
      template = templates[options.template]
      if not template?
        return callback new Error "unknown project-paginator template '#{ options.template }'"

      # setup the template context
      ctx = {@projects, @pageNum, @prevPage, @nextPage}

      # extend the template context with the enviroment locals
      env.utils.extend ctx, locals

      # finally render the template
      template.render ctx, callback

  # register a generator, 'project-paginator' here is the content group generated content will belong to
  # i.e. contents._.project-paginator
  env.registerGenerator 'project-paginator', (contents, callback) ->

    # find all projects
    projects = getProjects contents

    # populate pages
    numPages = Math.ceil projects.length / options.perPage
    pages = []
    for i in [0...numPages]
      pageProjects = projects.slice i * options.perPage, (i + 1) * options.perPage
      pages.push new ProjectPage i + 1, pageProjects

    # add references to prev/next to each page
    for page, i in pages
      page.prevPage = pages[i - 1]
      page.nextPage = pages[i + 1]

    # create the object that will be merged with the content tree (contents)
    # do _not_ modify the tree directly inside a generator, consider it read-only
    rv = {pages:{}}
    for page in pages
      rv.pages["#{ page.pageNum }.page"] = page # file extension is arbitrary
    rv['index.page'] = pages[0] # alias for first page
    rv['last.page'] = pages[(numPages-1)] # alias for last page

    # callback with the generated contents
    callback null, rv

  # add the project helper to the environment so we can use it later
  env.helpers.getProjects = getProjects

  # tell the plugin manager we are done
  callback()
