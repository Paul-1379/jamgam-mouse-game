extends RichTextLabel

var tasks: Array[String]
var tasks_completion: Array[bool]

func register_task(task_name):
	tasks.append(task_name)
	tasks_completion.append(false)
	refresh_text()
func refresh_text():
	text = ""
	var i = 0
	for task in tasks:
		var color = ("8CFF98" if tasks_completion[i] else "FF7363")
		text += "[color=#" + color + "]- " + task + "[/color]\n"
		i += 1
func task_completed(task_name):
	tasks_completion[tasks.find(task_name)] = true
	refresh_text()
