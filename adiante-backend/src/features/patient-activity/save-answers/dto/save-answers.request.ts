
export interface SaveAnswersRequest {
    patientId: string;
    executedTask: ExecutedTask;
}

export interface RequestAnswer {
    idQuestion: string;
    freeAnswerValue: string;
    idAnswer: string;
}

export interface FilledQuestionnaire {
    idQuestionnaire: string;
    answersList: RequestAnswer[];
}

export interface ExecutedTask {
    idScheduledTask: string;
    idTask: string;
    idParentExecutedTask: string;
    filledQuestionnaire: FilledQuestionnaire;
}

