Перем _norm_study;
Перем ГСЧ;

#Область ДополнительныеОбработки

Функция СведенияОВнешнейОбработке() Экспорт
	
	МассивНазначений = Новый Массив;
	
	ПараметрыРегистрации = Новый Структура;
	ПараметрыРегистрации.Вставить("Вид", "ДополнительнаяОбработка");
	ПараметрыРегистрации.Вставить("Назначение", МассивНазначений);
	ПараметрыРегистрации.Вставить("Наименование", "Нейронная сеть Кохонена (SOM)");
	ПараметрыРегистрации.Вставить("Версия", "2021.06.25");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация", ИнформацияПоИсторииИзменений());
	ПараметрыРегистрации.Вставить("ВерсияБСП", "1.2.1.4");
	ТаблицаКоманд = ПолучитьТаблицуКоманд();
	ДобавитьКоманду(ТаблицаКоманд,
	                "Нейронная сеть Кохонена (SOM)",
					"NeuralNetworkKohonen",
					"ОткрытиеФормы",
					Истина,
					"",
					"Форма"
					);

	ПараметрыРегистрации.Вставить("Команды", ТаблицаКоманд);
	
	Возврат ПараметрыРегистрации;
	
КонецФункции

Функция ПолучитьТаблицуКоманд()
	
	Команды = Новый ТаблицаЗначений;
	Команды.Колонки.Добавить("Представление", Новый ОписаниеТипов("Строка"));
	Команды.Колонки.Добавить("Идентификатор", Новый ОписаниеТипов("Строка"));
	Команды.Колонки.Добавить("Использование", Новый ОписаниеТипов("Строка"));
	Команды.Колонки.Добавить("ПоказыватьОповещение", Новый ОписаниеТипов("Булево"));
	Команды.Колонки.Добавить("ПросмотрВсе", Новый ОписаниеТипов("Булево"));
	Команды.Колонки.Добавить("Модификатор", Новый ОписаниеТипов("Строка"));
	Команды.Колонки.Добавить("ИмяФормы", Новый ОписаниеТипов("Строка"));
	
	Возврат Команды;
	
КонецФункции

Процедура ДобавитьКоманду(ТаблицаКоманд, Представление, Идентификатор, Использование, ПоказыватьОповещение = Ложь, Модификатор = "", ИмяФормы="",ПросмотрВсе=Истина)
	
	НоваяКоманда = ТаблицаКоманд.Добавить();
	НоваяКоманда.Представление = Представление;
	НоваяКоманда.Идентификатор = Идентификатор;
	НоваяКоманда.Использование = Использование;
	НоваяКоманда.ПоказыватьОповещение = ПоказыватьОповещение;
	НоваяКоманда.Модификатор = Модификатор;
	НоваяКоманда.ИмяФормы = ИмяФормы;
	НоваяКоманда.ПросмотрВсе = ПросмотрВсе;
	
КонецПроцедуры

Функция ИнформацияПоИсторииИзменений()
	Возврат "
	| <div style='text-indent: 25px;'>Данная обработка позволяет классифицировать состояние системы по данным замеров с помощью нейронной сети Кохонена</div>
	| <div style='text-indent: 25px;'>В текущий момент находится в разработке
	| <hr />
	| <div style='text-indent: 25px;'>Автор идеи: Крючков Владимир.</div>
	| <div style='text-indent: 25px;'>Реализовали: Крючков Владимир.</div>
	| <hr />
	| Подробную информацию смотрите по адресу интернет: <a target='_blank' href='https://github.com/Polyplastic/1c-parsing-tech-log'>https://github.com/Polyplastic/1c-parsing-tech-log</a>";
	
КонецФункции

Процедура ВыполнитьКоманду(Знач ИдентификаторКоманды, ПараметрыКоманды=Неопределено) Экспорт
	
	Если ИдентификаторКоманды="ПолучитьДанныеКластераФоново" Тогда
		
		// только при наличии параметров
		Если ПараметрыКоманды=Неопределено Тогда
			Возврат;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

// Вход 
Функция class_Input(Id=0) Экспорт
	
	Input = Новый Структура();
	
	// Связи с нейронами
	OutgoingLinks = новый Массив; //Link
	//Для ш=0 по колво_Input Цикл
	//	OutgoingLinks.Добавить(class_Link());
	//КонецЦикла;
	
	Input.Вставить("Id",Id);
	Input.Вставить("OutgoingLinks",OutgoingLinks);
	
	Возврат Input;
	
КонецФункции

// Связь входа с нейроном
Функция class_Link(Neuron=Неопределено,Weight=0) Экспорт
	
	Link = Новый Структура(); 
	
	// Нейрон
	Link.Вставить("Neuron", Neuron);
	
	Число = (ГСЧ.СлучайноеЧисло(0, 200)-100)/2000;
	
	// константа
	//Число = 0.5;
	
	// Вес связи
	Link.Вставить("Weight",?(Weight=0,Число,Weight));
	// Начальный вес
	Link.Вставить("StartWeight",Число);  
	
	Возврат Link;
	
КонецФункции

Функция class_Neuron(Id=0) Экспорт
	
	Neuron = Новый Структура();
	
	IncomingLinks = новый Массив;
	//Для ш=0 по колво_Link Цикл
	//	IncomingLinks.Добавить(class_Link());
	//КонецЦикла;	
	
	//Все входы нейрона
	Neuron.Вставить("IncomingLinks", IncomingLinks); //Link
	Neuron.Вставить("Cluster", "undefined"); //cluster
	Neuron.Вставить("Color", новый Структура("r,g,b",255,255,255)); //cluster
	
	Neuron.Вставить("func","1");
	
	// Накопленный нейроном заряд 
	Neuron.Вставить("Power",0);
	
	// Вставить номер
	Neuron.Вставить("Id",Id);
	
	// Вставить wins
	Neuron.Вставить("Wins",0);
	
	
	Возврат Neuron;
КонецФункции

Функция class_KohonenNetwork(колво_Input=0,колво_Neuron=0) Экспорт
	
	ГСЧ = Новый ГенераторСлучайныхЧисел(ТекущаяУниверсальнаяДатаВМиллисекундах());
	KohonenNetwork = новый Структура();
	
	// инициализация
	
	_inputs = новый Массив;
	
	Для ш=0 по колво_Input-1 Цикл
		_inputs.Добавить(class_Input(ш));
	КонецЦикла;
	
	KohonenNetwork.Вставить("_inputs",_inputs);
	
	_neurons = новый Массив;
	
	Для ш=0 по колво_Neuron-1 Цикл
		_neurons.Добавить(class_Neuron(ш));
	КонецЦикла;
	
	// добавим связи входов с нейронами
	_links = Новый Соответствие();
	Для ш=0 по колво_Input-1 Цикл 
		Для ч=0 по колво_Neuron-1 Цикл
			link = class_Link(_neurons[ч]);
			_inputs[ш].OutgoingLinks.Добавить("i"+ш+"n"+ч);
			_links.Вставить("i"+ш+"n"+ч,link);
		КонецЦикла;
	КонецЦикла;
	
	KohonenNetwork.Вставить("_links",_links);
	
	
	// добавим связи нейронов на входы
	Для ш=0 по колво_Neuron-1 Цикл
		Для ч=0 по колво_Input-1 Цикл
			link = _links.Получить("i"+ч+"n"+ч);
			_neurons[ш].IncomingLinks.Добавить("i"+ч+"n"+ш);
		КонецЦикла;		
	КонецЦикла;
	
	KohonenNetwork.Вставить("_neurons",_neurons);
	
	KohonenNetwork.Вставить("neuronLastId",колво_Neuron);
	
	Возврат KohonenNetwork;
	
КонецФункции

Функция class_KohonenNetworkMap(колво_Input=0,w_Neuron=0,h_Neuron=0,w_size=1,h_size=1) Экспорт
	
	колво_Neuron = w_Neuron*h_Neuron;
	
	ГСЧ = Новый ГенераторСлучайныхЧисел(ТекущаяУниверсальнаяДатаВМиллисекундах());
	KohonenNetwork = новый Структура();
	
	// инициализация
	
	_inputs = новый Массив;
	
	Для ш=0 по колво_Input-1 Цикл
		_inputs.Добавить(class_Input(ш));
	КонецЦикла;
	
	KohonenNetwork.Вставить("_inputs",_inputs);
	
	_neurons = новый Массив;
	
	Для ш=0 по колво_Neuron-1 Цикл
		_neurons.Добавить(class_Neuron(ш));
	КонецЦикла;
	
	// добавим связи входов с нейронами
	_links = Новый Соответствие();
	Для ш=0 по колво_Input-1 Цикл 
		ч=0;
		Для i=0 по w_Neuron-1 Цикл
			Для j=0 по h_Neuron-1 Цикл
				ч = i*w_Neuron+j;
				Weight = 0;
				Если ш=0 Тогда
					Weight = w_size/(w_Neuron-1)*i-w_size/2;
				Иначе
					Weight = h_size/(h_Neuron-1)*j-h_size/2;
				КонецЕсли;
				link = class_Link(_neurons[ч],Weight);
				_inputs[ш].OutgoingLinks.Добавить("i"+ш+"n"+ч);
				_links.Вставить("i"+ш+"n"+ч,link);
			КонецЦикла;
		КонецЦикла;
	КонецЦикла;
	
	KohonenNetwork.Вставить("_links",_links);
	
	
	// добавим связи нейронов на входы
	Для ш=0 по колво_Neuron-1 Цикл
		Для ч=0 по колво_Input-1 Цикл
			link = _links.Получить("i"+ч+"n"+ч);
			_neurons[ш].IncomingLinks.Добавить("i"+ч+"n"+ш);
		КонецЦикла;		
	КонецЦикла;
	
	KohonenNetwork.Вставить("_neurons",_neurons);
	
	KohonenNetwork.Вставить("neuronLastId",колво_Neuron);
	
	Возврат KohonenNetwork;
	
КонецФункции


Процедура УстановитьСкоростьОбучения(speed=0.5) Экспорт
	_norm_study = speed;
КонецПроцедуры

// Пропустить вектор через нейронную сеть 
Функция Handle(KohonenNetwork,input) Экспорт
	
	_inputs = KohonenNetwork._inputs;
	_neurons = KohonenNetwork._neurons;
	
	Для i=0 по _inputs.Количество()-1 Цикл
		inputNeuron = _inputs[i];
		Для каждого outgoingLink из inputNeuron.OutgoingLinks Цикл
			outgoingLink.Neuron.Power = outgoingLink.Neuron.Power+outgoingLink.Weight * input[i];
		КонецЦикла;
	КонецЦикла;
	
	maxIndex = 0;
	Для i=0 по _neurons.Количество()-1 Цикл
		
		Если (_neurons[i].Power > _neurons[maxIndex].Power) Тогда
			maxIndex = i;
		КонецЕсли; 
		//снять импульс со всех нейронов:
		Для каждого outputNeuron из _neurons Цикл
			outputNeuron.Power = 0;
		КонецЦикла; 
		
	КонецЦикла;
	Возврат maxIndex;
	
КонецФункции

Процедура Study(KohonenNetwork, input, correctAnswer) Экспорт
	
	_inputs = KohonenNetwork._inputs;
	_neurons = KohonenNetwork._neurons;
	
	neuron = _neurons[correctAnswer];
	Для i = 0 по neuron.IncomingLinks.Количество()-1 Цикл
		incomingLink = neuron.IncomingLinks[i];
		incomingLink.Weight = incomingLink.Weight + _norm_study * (input[i] - incomingLink.Weight);
	КонецЦикла;
	
КонецПроцедуры

Процедура StudySOM(KohonenNetwork, input_ms, epoch=1) Экспорт
	
	_inputs = KohonenNetwork._inputs;
	_neurons = KohonenNetwork._neurons;
	_links = KohonenNetwork._links;
	
	neuron = Неопределено;
	
	// определим нейрон победитель
	Для каждого точка из input_ms Цикл
		
		min_dist = 1000000000000;
		input = Новый Массив;
		input.Добавить(точка.x);
		input.Добавить(точка.y);
		
		Для i=0 по _neurons.Количество()-1 Цикл
			_neurons[i].Power = 0;
			Для j = 0 по _neurons[i].IncomingLinks.Количество()-1 Цикл
				incomingLink = _neurons[i].IncomingLinks[j];
				link = _links.Получить(incomingLink);
				_neurons[i].Power = _neurons[i].Power+(input[j]-link.Weight)*(input[j]-link.Weight) ;
				//_neurons[i].Power = _neurons[i].Power+?((input[j]-link.Weight)<0,-(input[j]-link.Weight),(input[j]-link.Weight)) ;
			КонецЦикла; 	
			
		КонецЦикла;
		
		Для i=0 по _neurons.Количество()-1 Цикл
			Если (_neurons[i].Power<min_dist) Тогда
				neuron = _neurons[i];
				min_dist = _neurons[i].Power;
			КонецЕсли;
		КонецЦикла;		
		
		// Увеличим победы
		neuron.Wins = neuron.Wins+1;
		//Для i = 0 по neuron.IncomingLinks.Количество()-1 Цикл
		//	incomingLink = neuron.IncomingLinks[i];
		//	link = _links.Получить(incomingLink);
		//	link.Weight = link.Weight + (_norm_study) * (input[i] - link.Weight);
		//	_links.Вставить(incomingLink,link);
		//КонецЦикла;
		
		Для i=0 по _neurons.Количество()-1 Цикл
			//Если _neurons[i]=neuron Тогда
			//	Продолжить;
			//КонецЕсли;
			
			Для j = 0 по _neurons[i].IncomingLinks.Количество()-1 Цикл
				incomingLinkWinner = neuron.IncomingLinks[j];
				linkWinner = _links.Получить(incomingLinkWinner);
				incomingLink = _neurons[i].IncomingLinks[j];
				link = _links.Получить(incomingLink);
				r = Exp(-(linkWinner.Weight-link.Weight)*(linkWinner.Weight-link.Weight)/(6));
				link.Weight = Окр(link.Weight + (_norm_study*r) * (input[j] - link.Weight),10);
				_links.Вставить(incomingLink,link);
			КонецЦикла; 	
			
		КонецЦикла;
		
		
	КонецЦикла;
	
КонецПроцедуры

Процедура StudySOM1(KohonenNetwork, input_ms, epoch=1) Экспорт
	
	_inputs = KohonenNetwork._inputs;
	_neurons = KohonenNetwork._neurons;
	_links = KohonenNetwork._links;
	
	neuron = Неопределено;
	min_dist = 1000000000000;
	// определим нейрон победитель
	Для каждого точка из input_ms Цикл
		
		input = Новый Массив;
		input.Добавить(точка.x);
		input.Добавить(точка.y);
		
		Для i=0 по _neurons.Количество()-1 Цикл
			_neurons[i].Power = 0;
			Для j = 0 по _neurons[i].IncomingLinks.Количество()-1 Цикл
				incomingLink = _neurons[i].IncomingLinks[j];
				link = _links.Получить(incomingLink);
				//_neurons[i].Power = _neurons[i].Power+(input[j]-link.Weight)*(input[j]-link.Weight) ;
				_neurons[i].Power = _neurons[i].Power+?((input[j]-link.Weight)<0,-(input[j]-link.Weight),(input[j]-link.Weight)) ;
			КонецЦикла; 	
			
		КонецЦикла;
		
		Для i=0 по _neurons.Количество()-1 Цикл
			Если (_neurons[i].Power<min_dist) Тогда
				neuron = _neurons[i];
				min_dist = _neurons[i].Power;
			КонецЕсли;
		КонецЦикла;		
		
		Для i = 0 по neuron.IncomingLinks.Количество()-1 Цикл
			incomingLink = neuron.IncomingLinks[i];
			link = _links.Получить(incomingLink);
			link.Weight = link.Weight + (_norm_study) * (input[i] - link.Weight);
			//_links.Вставить(incomingLink,link);
		КонецЦикла;
		
		
	КонецЦикла;
	
КонецПроцедуры

Процедура StudySOMmod(KohonenNetwork, input_ms, epoch=1) Экспорт
	
	_inputs = KohonenNetwork._inputs;
	_neurons = KohonenNetwork._neurons;
	_links = KohonenNetwork._links;
	
	neuron = Неопределено;
	min_dist = 10000000000;
	// определим нейрон победитель
	Для каждого точка из input_ms Цикл
		
		input = Новый Массив;
		input.Добавить(точка.x);
		input.Добавить(точка.y);
		
		Для i=0 по _neurons.Количество()-1 Цикл
			_neurons[i].Power = 0;
			Для j = 0 по _neurons[i].IncomingLinks.Количество()-1 Цикл
				incomingLink = _neurons[i].IncomingLinks[j];
				link = _links.Получить(incomingLink);
				_neurons[i].Power = _neurons[i].Power+(input[j]-link.Weight)*(input[j]-link.Weight) ;
			КонецЦикла; 	
			
		КонецЦикла;
		
	КонецЦикла;
	
	Для i=0 по _neurons.Количество()-1 Цикл
		Если (_neurons[i].Power<min_dist) Тогда
			neuron = _neurons[i];
			min_dist = _neurons[i].Power;
		КонецЕсли;
	КонецЦикла;
	
	Для каждого точка из input_ms Цикл
		
		input = Новый Массив;
		input.Добавить(точка.x);
		input.Добавить(точка.y);
		
		
		Для i = 0 по neuron.IncomingLinks.Количество()-1 Цикл
			incomingLink = neuron.IncomingLinks[i];
			link = _links.Получить(incomingLink);
			link.Weight = link.Weight + (_norm_study) * (input[i] - link.Weight);
			_links.Вставить(incomingLink,link);
		КонецЦикла;
		
	КонецЦикла;

	
КонецПроцедуры


// делим на два область
Процедура РазбитьНаДва(KohonenNetwork) Экспорт
	
	ГСЧ = Новый ГенераторСлучайныхЧисел(ТекущаяУниверсальнаяДатаВМиллисекундах());
	
	_inputs 		= KohonenNetwork._inputs;
	_neurons 		= KohonenNetwork._neurons;
	_links 			= KohonenNetwork._links;
	neuronLastId 	= KohonenNetwork.neuronLastId;
	
	СилаДеления = 1;
	
	НейроновДо = _neurons.Количество(); 
	
	Для i=0 по НейроновДо-1 Цикл
		// новый нейрон
		IdNew = neuronLastId;
		new_neuron = class_Neuron(IdNew); 
		_neurons.Добавить(new_neuron);
		neuronLastId = neuronLastId+1;
		
		// добавим связи 
		Для j=0 по _inputs.Количество()-1 Цикл
			link = class_Link(new_neuron);
			_inputs[j].OutgoingLinks.Добавить("i"+j+"n"+IdNew);
			_links.Вставить("i"+j+"n"+IdNew,link);
			
			new_neuron.IncomingLinks.Добавить("i"+j+"n"+IdNew);

		КонецЦикла;
	
		// добавим веса
		Для j = 0 по _neurons[i].IncomingLinks.Количество()-1 Цикл
			incomingLink = _neurons[i].IncomingLinks[j];
			link = _links.Получить(incomingLink);
			
			incomingLinkNew = new_neuron.IncomingLinks[j];
			linkNew = _links.Получить(incomingLinkNew);
			// разделим
			
			linkNew.Weight = link.Weight+СилаДеления;
			link.Weight=link.Weight-СилаДеления;
		КонецЦикла;

	КонецЦикла;
	
	KohonenNetwork.neuronLastId = neuronLastId;
	
КонецПроцедуры

// удаляем мертвые или очень близкие
Процедура УдалитьМертвыеНейроны(KohonenNetwork) Экспорт
	
	_inputs = KohonenNetwork._inputs;
	_neurons = KohonenNetwork._neurons;
	_links = KohonenNetwork._links;
	
	ДистанцияУдаления = 1.4;
	МинимумПобед = 5;
	СреднееЧислоПобед = 0;
	Для i=0 по _neurons.Количество()-1 Цикл
		СреднееЧислоПобед = СреднееЧислоПобед + _neurons[i].Wins/_neurons.Количество();
	КонецЦикла;
	СреднееЧислоПобед=СреднееЧислоПобед/10;

	
	НейроныКУдалению = новый Массив;
	НейроныКСлиянию = новый Массив;
	
	// Удалим, которые не свдинулись
	Для i=0 по _neurons.Количество()-1 Цикл
		
		МертвыйНейрон = Истина;
		Для j = 0 по _neurons[i].IncomingLinks.Количество()-1 Цикл
			
			incomingLink = _neurons[i].IncomingLinks[j];
			link = _links.Получить(incomingLink);
			
			Если link.Weight<>link.StartWeight Тогда
				МертвыйНейрон = Ложь;
				Прервать;
			КонецЕсли;
			
		КонецЦикла;
				
		Если МертвыйНейрон=Истина Тогда
			НейроныКУдалению.Добавить(_neurons[i]);
		КонецЕсли;
		
	КонецЦикла;
	
	// Удалим, которые не побеждали
	Для i=0 по _neurons.Количество()-1 Цикл
		
		Если _neurons[i].Wins<=МинимумПобед ИЛИ _neurons[i].Wins<=СреднееЧислоПобед Тогда
			НейроныКУдалению.Добавить(_neurons[i]);
		КонецЕсли;
		
	КонецЦикла;
	
	// Удалим, которых расстояние мало
	Для i=0 по _neurons.Количество()-1 Цикл
		
		Для j=i+1 по _neurons.Количество()-1 Цикл
			
			dist = 0;
			
			Для q=0 по _neurons[i].IncomingLinks.Количество()-1 Цикл
				incomingLink = _neurons[i].IncomingLinks[q];
				link = _links.Получить(incomingLink);
				
				incomingLinkTested = _neurons[j].IncomingLinks[q];
				linkTested = _links.Получить(incomingLinkTested);
				
				
				dist = dist + (link.Weight-linkTested.Weight)*(link.Weight-linkTested.Weight);
				
				
			КонецЦикла;
			
			Если dist<ДистанцияУдаления Тогда
				НейроныКСлиянию.Добавить(новый Структура("neuron_in,neuron_out",_neurons[i],_neurons[j]));
			КонецЕсли;
				
			
		КонецЦикла;
		
	КонецЦикла;
	
	// Сольем ейроны
	Для каждого пара из НейроныКСлиянию Цикл
		//TODO: тут надо бы слить веса по среднему
		// поместим в удаление
		НейроныКУдалению.Добавить(пара.neuron_out);
	КонецЦикла;
	
	// Удалим нейроны
	Для Каждого нейрон из НейроныКУдалению Цикл
		
		// удалим связи выходов
		Для i = 0 по _inputs.Количество()-1 Цикл
			МассивСвязейКУдалению = новый Массив;
			Для j=0 по _inputs[i].OutgoingLinks.Количество()-1 Цикл
				Если найти(_inputs[i].OutgoingLinks[j],"i"+i+"n"+нейрон.Id) Тогда
					МассивСвязейКУдалению.Добавить(j);
				КонецЕсли;
			КонецЦикла;
			
			Для каждого св из МассивСвязейКУдалению Цикл
				Попытка
					_inputs[i].OutgoingLinks.Удалить(св);
				Исключение
					Сообщить(ОписаниеОшибки());
				КонецПопытки;				
			КонецЦикла;
			
		КонецЦикла;
		
		// удалим сам нейрон	
		Попытка
			_neurons.Удалить(_neurons.найти(нейрон));
		Исключение
			Сообщить(ОписаниеОшибки());
		КонецПопытки;
		
	КонецЦикла;
	
	
	Для i=0 по _neurons.Количество()-1 Цикл
		 _neurons[i].Wins=0;
	КонецЦикла;	
	
КонецПроцедуры

// Обучение завершено, когда более нет конкуренции и колчиество побед синхронно

// инициализируем
_norm_study = 0.5;