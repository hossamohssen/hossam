import { useState, useEffect } from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Progress } from "@/components/ui/progress";
import { Input } from "@/components/ui/input";

const tasks = [
  { id: 1, title: "Watch 3Blue1Brown Linear Algebra Ep. 1", done: false },
  { id: 2, title: "Complete Week 1 of Math for ML - Coursera", done: false },
  { id: 3, title: "Leetcode Python Practice - 5 problems", done: false },
];

const resources = [
  { title: "Python for Everybody", type: "Course", link: "https://www.coursera.org/specializations/python", done: true },
  { title: "Math for Machine Learning", type: "Course", link: "https://www.coursera.org/learn/linear-algebra-machine-learning", done: false },
  { title: "NLP Specialization", type: "Course", link: "https://www.coursera.org/specializations/natural-language-processing", done: false },
];

export default function Home() {
  const [taskList, setTaskList] = useState(tasks);
  const [newTask, setNewTask] = useState("");

  const handleToggle = (id) => {
    const updated = taskList.map((task) =>
      task.id === id ? { ...task, done: !task.done } : task
    );
    setTaskList(updated);
  };

  const handleAddTask = () => {
    if (!newTask.trim()) return;
    const nextId = taskList.length + 1;
    setTaskList([...taskList, { id: nextId, title: newTask, done: false }]);
    setNewTask("");
  };

  const completedTasks = taskList.filter((t) => t.done).length;
  const progress = Math.round((completedTasks / taskList.length) * 100);

  return (
    <div className="min-h-screen p-6 bg-gray-100 text-gray-900">
      <h1 className="text-3xl font-bold mb-4">📘 My AI Learning Tracker</h1>

      <Card className="mb-6">
        <CardContent className="p-4">
          <h2 className="text-xl font-semibold mb-2">✅ To-Do List</h2>
          <div className="space-y-2">
            {taskList.map((task) => (
              <div key={task.id} className="flex items-center justify-between">
                <label className="flex items-center gap-2">
                  <input
                    type="checkbox"
                    checked={task.done}
                    onChange={() => handleToggle(task.id)}
                    className="accent-blue-500"
                  />
                  <span className={task.done ? "line-through" : ""}>{task.title}</span>
                </label>
              </div>
            ))}
            <div className="flex gap-2 mt-3">
              <Input
                type="text"
                placeholder="Add a new task"
                value={newTask}
                onChange={(e) => setNewTask(e.target.value)}
              />
              <Button onClick={handleAddTask}>Add</Button>
            </div>
          </div>
        </CardContent>
      </Card>

      <Card className="mb-6">
        <CardContent className="p-4">
          <h2 className="text-xl font-semibold mb-2">📚 Resources</h2>
          <ul className="space-y-2">
            {resources.map((res, idx) => (
              <li key={idx}>
                <a
                  href={res.link}
                  target="_blank"
                  className={`underline ${res.done ? "text-green-600" : "text-blue-600"}`}
                >
                  {res.title} ({res.type})
                </a>
              </li>
            ))}
          </ul>
        </CardContent>
      </Card>

      <Card>
        <CardContent className="p-4">
          <h2 className="text-xl font-semibold mb-2">📈 Progress</h2>
          <Progress value={progress} className="h-4" />
          <p className="mt-2">{progress}% of tasks completed</p>
        </CardContent>
      </Card>
    </div>
  );
}
