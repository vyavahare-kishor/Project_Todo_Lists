$(document).ready(function() {
    console.log('hi');
  $("#add").unbind().click(function(e) {
    e.preventDefault();
    console.log('hell')
    var todo = $(".todos div.fields:last").clone()
    var id = todo.find('input:text').attr('id')
    var count = parseInt(id.replace(/project_todo_lists_attributes_(\d+)_name/,"$1")) + 1
    console.log(count)
    var input_field = $('<div class="fields"><input class="form-control" type="text" name="project[todo_lists_attributes]['+ count +'][name]" id="project_todo_lists_attributes_'+ count +'_name"><input type="hidden" value="false" name="project[todo_lists_attributes][' + count +'][_destroy]" id="project_todo_lists_attributes_'+ count +'__destroy"><a class="remove_nested_fields" data-association="todo_lists" href="javascript:void(0)">Remove this todo</a></div>')
    $('.todos').append(input_field)

  });
});