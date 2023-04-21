import { TaskType } from "./TaskType";
import { Task } from "./Task";
import {Question} from "./Question";
import {QuestionType} from "./QuestionType";
import {Answer} from "./Answer";
import { Questionnaire } from "./Questionnaire";
import { QuestionnaireType } from "./QuestionnaireType";

/**
 * @param {any} taskRowResults 
 * @returns {Task}
 */
export async function mapTask(taskRowResults: any): Promise<Task> {

    let task: Task | null = null;
    
    if (taskRowResults && taskRowResults.length > 0) {
        taskRowResults.map((result: any) => {
            const taskType = new TaskType(result.task_type_code_name);
            task = new Task(result.id, result.code_name, result.free_execution, result.updatedAt, taskType,undefined);
        });
    }
    return task!;
}


/**
 * @param {any} taskRowResults 
 * @returns {Task}
 */
export async function mapToTaskQuestionnaire(queryResult: any[]): Promise<Task> {

    let currentTask: Task = new Task('', '', false, new Date(), new TaskType(''));
    let currentQuestionnaire: Questionnaire | undefined;
    let currentQuestion: Question | undefined;
  
    queryResult.forEach((row) => {
      if (!currentTask || currentTask.id !== row.id_task.toString()) {
        currentTask = new Task(
          row.id_task.toString(),
          row.task_code_name,
          row.free_execution,
          new Date(),
          new TaskType(row.task_type)
        );
      }
  
      if (!currentQuestionnaire || currentQuestionnaire.id !== row.id_questionnaire.toString()) {
        currentQuestionnaire = new Questionnaire();
        currentQuestionnaire.id = row.id_questionnaire.toString();
        currentQuestionnaire.questionnaireType = new QuestionnaireType(row.questionnaire_type);
        currentQuestionnaire.questions = [];
        currentTask.questionnaire = currentQuestionnaire;
      }
  
      if (!currentQuestion || currentQuestion.id !== row.id_question.toString()) {
        currentQuestion = new Question();
        currentQuestion.id = row.id_question.toString();
        currentQuestion.idQuestionnaires = row.id_questionnaire.toString();
        currentQuestion.i18n = row.question_value;
        currentQuestion.questionType = new QuestionType(row.question_type);
        currentQuestion.answers = [];
        currentQuestionnaire.questions.push(currentQuestion);
      }
  
      const answer = new Answer();
      answer.id = row.id_answer.toString();
      answer.idQuestion = row.id_question.toString();
      answer.i18n = row.answer_value;
      currentQuestion.answers.push(answer);
    });
  
    return currentTask;
  }
