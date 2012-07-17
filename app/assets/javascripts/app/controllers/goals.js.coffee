class App.Controller.Goals_New extends Spine.Controller
  constructor: ->
    @render()
    @events()

  events: ->
    $("#create_new_goal_button").live('click', @save)
    $("#new_goal_form").live('submit', @save)
    $("td").live('click', @toggle_day)

  render: ->
    $(".dialogs").append @view('goals/new')(@)
    $('#new_goal_modal').modal(show: true);
    @show();

  toggle_day: ->
    if $(this).hasClass('not-selected')
      $(this).removeClass('not-selected')
    else
      $(this).addClass('not-selected') 

  show: ->
    $('#new_goal_modal').modal('show');
    $("#new_goal_modal input").focus();

  hide: ->
    $("#new_goal_modal").modal('hide');

  save: (e) =>
    e.preventDefault();
    $.ajax({
      type: 'POST',
      url: '/api/v1/goals.json',
      data: { 
              goal: @getFormValues(),
              token: $('.user-meta').data('token')
            },
      success: (response) =>
        @hide()
        $("#alert-bar").addClass('alert-success').text('Congratulations on creating a goal!').hide()
        $("#alert-bar").slideDown().delay(3000).slideUp()
    });

  getFormValues: ->
    JSON.stringify({
      name: $('#goal-name').val()
    })

class App.Controller.Goals extends Spine.Controller
  constructor: ->
    super
    @new_goal_dialog = new App.Controller.Goals_New()