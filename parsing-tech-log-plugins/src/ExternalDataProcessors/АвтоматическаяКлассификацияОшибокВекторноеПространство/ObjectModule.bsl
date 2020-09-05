#Область ДополнительныеОбработки

Функция СведенияОВнешнейОбработке() Экспорт
	
	МассивНазначений = Новый Массив;
	
	ПараметрыРегистрации = Новый Структура;
	ПараметрыРегистрации.Вставить("Вид", "ДополнительнаяОбработка");
	ПараметрыРегистрации.Вставить("Назначение", МассивНазначений);
	ПараметрыРегистрации.Вставить("Наименование", "Автоклассификация ошибок ТЖ");
	ПараметрыРегистрации.Вставить("Версия", "2020.09.06");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация", ИнформацияПоИсторииИзменений());
	ПараметрыРегистрации.Вставить("ВерсияБСП", "1.2.1.4");
	ТаблицаКоманд = ПолучитьТаблицуКоманд();
	ДобавитьКоманду(ТаблицаКоманд,
	                "Настройка 'Автоклассификация ошибок технологического журнала'",
					"НастройкаАвтоклассификацииТехнологическогоЖурнала",
					"ОткрытиеФормы",
					Истина,
					"",
					"ФормаНастроек"
					);
	ДобавитьКоманду(ТаблицаКоманд,
	                "Монитор 'Классификация ошибок'",
					"МониторПоКлассификацииОшибок",
					"ОткрытиеФормы",
					Истина,
					"",
					"ФормаМонитора"
					); 					
	ДобавитьКоманду(ТаблицаКоманд,
	                "ВыполнитьАвтоклассификациюФоново",
					"ВыполнитьАвтоклассификациюФоново",
					"ВызовСерверногоМетода",
					Ложь,
					"",
					"ФормаМонитора",
					Ложь
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
	| <div style='text-indent: 25px;'>Данная обработка позволяет выполнять автоматическую классификацию текста ошибок ТЖ</div>
	| <div style='text-indent: 25px;'>Форма Настройка 'Автоклассификация ошибок технологического журнала' выполнить настройку классификации</div>
	| <div style='text-indent: 25px;'>Форма 'Журнал классификации' позволяет выполнить просмотр и анализ результатов</div>
	| <hr />
	| Подробную информацию смотрите по адресу интернет: <a target='_blank' href='https://github.com/Polyplastic/1c-parsing-tech-log'>https://github.com/Polyplastic/1c-parsing-tech-log</a>";
	
КонецФункции

Процедура ВыполнитьКоманду(Знач ИдентификаторКоманды, ПараметрыКоманды=Неопределено) Экспорт
	
	Если ИдентификаторКоманды="ВыполнитьАвтоклассификациюФоново" Тогда
		
		// только при наличии параметров
		Если ПараметрыКоманды=Неопределено Тогда
			Возврат;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область АвтоклассификацияДанных

Процедура ВыполнитьЗагрузкуДанных(Замер,ДополнительнаяОбработка=Неопределено) Экспорт
	
	ВыполнитьАвтоклассификацию(Замер);	
	
КонецПроцедуры

Функция ВыполнитьАвтоклассификацию(Замер)
	
	// получим настройки загрузки
	мНастройка = УправлениеХранилищемНастроекВызовСервера.ДанныеИзБезопасногоХранилища(Замер);
	
	Если мНастройка=Неопределено Тогда
		ЗаписьЖурналаРегистрации("ЗагрузитьДанныеВЗамерСервер",УровеньЖурналаРегистрации.Ошибка,Неопределено,Замер,"Не созданы настройки для операции произвольной загрузки по замеру ("+Замер+")");
		Возврат 0;
	КонецЕсли;
	
	ЗаписыватьРезультатОбработкиВИсходныйЗамер = мНастройка.ЗаписыватьРезультатОбработкиВИсходныйЗамер;
	ЗаписыватьРезультатОбработкиВКлассификатор = мНастройка.ЗаписыватьРезультатОбработкиВКлассификатор;
	ЗаписыватьРезультатОбработкиТекущийЗамер = мНастройка.ЗаписыватьРезультатОбработкиТекущийЗамер;
	ГруппировкаПоВремени = мНастройка.ГруппировкаПоВремени;
	
	РазмерФайла = 0;
	ПрочитаноСтрок = 0;
	ДатаНачалаЧтения = ТекущаяДата();
	ДатаПрочитанныхДанных = Неопределено;
	
	
	//инициализация фильтров
	РеквизитыЗамера = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Замер, "ФильтрТипСобытия,ФильтрСвойстваСобытия,ФильтрСвойстваСобытияКроме,ФильтрДлительность,НачалоПериода,КонецПериода,ТипЗамера,ДополнительнаяОбработка");
	РеквизитыЗамера.Вставить("ФильтрТипСобытия", РеквизитыЗамера.ФильтрТипСобытия.Получить());
	
		
	СвойстваСправочника = новый Структура("ЧисловойРежим",Истина);
	
	// выбираем не обработанный текст пачкой и обрабатываем
	// добавить сюда вывод данных в замер
	// ДатаПрочитанныхДанных
	
	// загрузим стопфразы
	мНастройка.Вставить("СтопФразы", ПолучитьСтопФразы(?(мНастройка.Свойство("СтопФразы"),мНастройка.СтопФразы,ПолучитьМакетНаСервере("СтопФразы").ПолучитьТекст())));
	// загрузим синонимы
	мНастройка.Вставить("ФразыСинонимы",ПолучитьФразыСинонимы(?(мНастройка.Свойство("ФразыСинонимы"),мНастройка.ФразыСинонимы,ПолучитьМакетНаСервере("ФразыСинонимы").ПолучитьТекст())));
	// загрузим СтопСлова
	мНастройка.Вставить("СтопСлова",ПолучитьСтопСлов(?(мНастройка.Свойство("СтопСлова"),мНастройка.СтопСлова,ПолучитьМакетНаСервере("СтопСлова").ПолучитьТекст())));
	// ТаблицаВажностиСлов
	мНастройка.Вставить("ТаблицаВажностиСлов",новый ТаблицаЗначений);
	// ВекторСловСписком
	мНастройка.Вставить("ВекторСловСписком",СформироватьВекторСловСписком(мНастройка.БазисСлов));
	// КешРасчетныхДанных
	мНастройка.Вставить("КешРасчетныхДанных",новый Соответствие);
	// КешСжатыхВекторов
	мНастройка.Вставить("КешСжатыхВекторов",новый Соответствие);
	// КешДанныхСжатыхВекторов
	мНастройка.Вставить("КешДанныхСжатыхВекторов",новый Соответствие);
	
	Запрос = новый Запрос;
	Запрос.Текст = ПолучитьТекстЗапросаВыборки();
	
	Если мНастройка.РазмерПакета=0 Тогда		
		Запрос.Текст = СтрЗаменить(Запрос.Текст,"ПЕРВЫЕ 200","");
	Иначе
		Запрос.Текст = СтрЗаменить(Запрос.Текст,"200",формат(мНастройка.РазмерПакета,"ЧГ="));
	КонецЕсли;
	
	// инициализация классификатора
	ЗапросКлассификатор = новый Запрос;
	ЗапросКлассификатор.Текст = ПолучитьТекстЗапросаКлассификатора();
	ЗапросКлассификатор.УстановитьПараметр("Корень",мНастройка.Классификатор);
	ТаблицаКлассификатор = ЗапросКлассификатор.Выполнить().Выгрузить();
	КешОбработанныхСтрокКлассификатора = новый Соответствие;
	КешСобытийГруппаПоВремени = новый Соответствие;
	ДатаПервогоСобытияВыборки = Неопределено;
	
	
	Для каждого настройка из мНастройка.ТаблицаНастроекВыборки Цикл

		АдресURL = "/Замер/"+Строка(настройка.Замер.UUID())+"/"+Строка(настройка.Свойство.UUID()); 
				
		ФайлЗамера = Справочники.ФайлыЗамера.ПолучитьФайлПоПолномуИмени(Замер, АдресURL);
		
		//еще раз проверим прочитан полностью
		СостояниеЧтения = РегистрыСведений.СостояниеЧтения.ПолучитьСостояние(ФайлЗамера);
		Если СостояниеЧтения.ЧтениеЗавершено Тогда
			Продолжить;
		КонецЕсли; 			
		
		ПрочитаноСтрок = СостояниеЧтения.ПрочитаноСтрок;
		ДатаПрочитанныхДанных = СостояниеЧтения.ДатаПрочитанныхДанных;
		
		Запрос.УстановитьПараметр("Замер",настройка.Замер);
		Запрос.УстановитьПараметр("Свойство",настройка.Свойство);
		Запрос.УстановитьПараметр("ДатаСобытия",ДатаПрочитанныхДанных);				
		
		Результат = Запрос.Выполнить();
		
		Если Результат.Пустой() Тогда
			Возврат 0;
		КонецЕсли;
		Выборка = Результат.Выбрать();
		
		Пока Выборка.Следующий() Цикл
			
			// 1) формируем вектор текста ошибки
			КлючОшибки = Неопределено;
			ВекторОшибки = ПолучитьВекторЗапроса(Выборка.Текст,ТаблицаКлассификатор.Количество(),мНастройка);
			КлассОсновной = Неопределено;
			КлассВторичный = Неопределено;
			КосинусОсновной = 0;
			КосинусВторичный = 0;
			Если ДатаПервогоСобытияВыборки=Неопределено Тогда
				ДатаПервогоСобытияВыборки = ПриобразоватьВремяКИнтервалу(ГруппировкаПоВремени,Выборка.ДатаСобытия);
			КонецЕсли;
			
			// 2) выполняем классификацию
			Для каждого класс из ТаблицаКлассификатор Цикл
				
				Если НЕ ЗначениеЗаполнено(класс.Текст) Тогда
					Продолжить;
				КонецЕсли;
				
				// 2.1) формируем вектор класса или берем из кеша
				КлючКласса = класс.Наименование+"/"+Строка(класс.Ссылка.UUID());
				ВекторКласса = КешОбработанныхСтрокКлассификатора.Получить(КлючКласса);
				Если ВекторКласса=Неопределено Тогда
					ВекторКласса = ПолучитьВекторЗапроса(класс.Текст,ТаблицаКлассификатор.Количество(),мНастройка);
					КешОбработанныхСтрокКлассификатора.Вставить(КлючКласса,ВекторКласса);
				КонецЕсли;
				
				
				// 2.2) получаем косинус
				Косинус = ПолучитьКосинусВекторов(ВекторКласса,КлючКласса,ВекторОшибки,КлючОшибки,мНастройка);
				
				// 2.3) выполняем классификацию
				Если Косинус>класс.НижняяГраница Тогда
					
					Если КосинусОсновной<Косинус Тогда
						КосинусВторичный = КосинусОсновной;
						КлассВторичный = КлассОсновной;
						КосинусОсновной = Косинус;
						КлассОсновной = класс.Ссылка;
					ИначеЕсли КосинусВторичный<Косинус Тогда
						КосинусВторичный = Косинус;
						КлассВторичный = класс.Ссылка;
					КонецЕсли;
					
				КонецЕсли;		
			
			КонецЦикла;
			
			// 3) формируем запись результата
			// 3.1) Регистр классификация
			Если ЗаписыватьРезультатОбработкиВКлассификатор=Истина Тогда
				ЗаписатьРезультатРегистрКлассификации(Выборка, Замер, КлассОсновной, КлассВторичный, КосинусОсновной, КосинусВторичный,мНастройка.СохранятьВторойКласс);
			КонецЕсли;
			// 3.2) Исходгный замер
			Если ЗаписыватьРезультатОбработкиВИсходныйЗамер=Истина Тогда
				ЗаписатьРезультатИсходныйЗамер(Выборка,Замер,КлассОсновной,КосинусОсновной);
			КонецЕсли;
			
			// 3.3) Текущий замер, группировки
			Если ЗаписыватьРезультатОбработкиТекущийЗамер=Истина Тогда
				ГруппаПоВремени = ПриобразоватьВремяКИнтервалу(ГруппировкаПоВремени,Выборка.ДатаСобытия);
				КешСобытий = КешСобытийГруппаПоВремени.Получить(ГруппаПоВремени);
				Если КешСобытий=Неопределено Тогда
					КешСобытий = новый Соответствие;
					КешСобытийГруппаПоВремени.Вставить(ГруппаПоВремени,КешСобытий);
				КонецЕсли;
				Если КлассОсновной=Неопределено Тогда
					Частота = КешСобытий.Получить("Неопределено##ОшибкаКлассификации");
				Иначе
					Частота = КешСобытий.Получить(КлассОсновной);
				КонецЕсли;
				Если Частота=Неопределено Тогда
					Частота = 0;
				КонецЕсли;
				Если КлассОсновной=Неопределено Тогда
					КешСобытий.Вставить("Неопределено##ОшибкаКлассификации",Частота+1);
				Иначе
					КешСобытий.Вставить(КлассОсновной,Частота+1);
				КонецЕсли;
			КонецЕсли;
			
			// двигаем дату
			ДатаПрочитанныхДанных = Выборка.ДатаСобытия;
			ПрочитаноСтрок = ПрочитаноСтрок + 1;
		
		КонецЦикла;
		
		// сохраним групповые значения
		Если ЗаписыватьРезультатОбработкиТекущийЗамер=Истина Тогда
			
			ПервоеСобытиеЗамерВыборки = Неопределено;
			Запрос = новый Запрос;
			Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
			|	СобытияЗамера.Ссылка КАК Ссылка
			|ИЗ
			|	Справочник.СобытияЗамера КАК СобытияЗамера
			|ГДЕ
			|	СобытияЗамера.Владелец = &Замер
			|	И СобытияЗамера.ДатаСобытия = &ДатаСобытия";
			Запрос.УстановитьПараметр("Замер",Замер);
			Запрос.УстановитьПараметр("ДатаСобытия",ПриобразоватьВремяКИнтервалу(ГруппировкаПоВремени,ДатаПервогоСобытияВыборки));
			
			Выборка = Запрос.Выполнить().Выбрать();
			Если Выборка.Следующий() Тогда
				ПервоеСобытиеЗамерВыборки = Выборка.Ссылка;
			КонецЕсли;		
			
			Для каждого группа из КешСобытийГруппаПоВремени Цикл
				
				// для первого события допишем данные
				Если НЕ ПервоеСобытиеЗамерВыборки=Неопределено И группа.Ключ=ДатаПервогоСобытияВыборки Тогда
					СобытиеЗамераОбъект = ПервоеСобытиеЗамерВыборки.ПолучитьОбъект();
					Для каждого эл из группа.Значение Цикл
						Если эл.Ключ="Неопределено##ОшибкаКлассификации" Тогда
							Свойство = СправочникиСерверПовтИсп.ПолучитьСвойствоПоИмениСинониму("unknown","unknown",СвойстваСправочника);
						Иначе
							Свойство = СправочникиСерверПовтИсп.ПолучитьСвойствоПоИмениСинониму(эл.Ключ,эл.Ключ,СвойстваСправочника);
						КонецЕсли;
						мОтбор = новый Структура("Свойство",Свойство);
						н_строки = СобытиеЗамераОбъект.КлючевыеСвойства.НайтиСтроки(мОтбор);
						Если н_строки.Количество()>0 тогда
							стр_н = н_строки[0];
						Иначе
							стр_н = СобытиеЗамераОбъект.КлючевыеСвойства.Добавить();
							стр_н.Свойство = Свойство;
						КонецЕсли;
						стр_н.ЗначениеЧисло = стр_н.ЗначениеЧисло+эл.Значение;
						стр_н.Значение = XMLСтрока(стр_н.ЗначениеЧисло);
					КонецЦикла;
					ВыполнитьАвтоклассификациюФрагмент(СвойстваСправочника, СобытиеЗамераОбъект);
				Иначе // добавляем новые
					СобытиеЗамераОбъект = Справочники.СобытияЗамера.СоздатьЭлемент();
					СобытиеЗамераОбъект.Владелец = Замер;
					СобытиеЗамераОбъект.Файл = ФайлЗамера;
					СобытиеЗамераОбъект.ДатаСобытия = группа.Ключ;
					Для каждого эл из группа.Значение Цикл
						стр_н = СобытиеЗамераОбъект.КлючевыеСвойства.Добавить();   
						Если эл.Ключ="Неопределено##ОшибкаКлассификации" Тогда
							стр_н.Свойство = СправочникиСерверПовтИсп.ПолучитьСвойствоПоИмениСинониму("Unknown","Unknown",СвойстваСправочника);
						Иначе
							стр_н.Свойство = СправочникиСерверПовтИсп.ПолучитьСвойствоПоИмениСинониму(эл.Ключ,эл.Ключ,СвойстваСправочника);
						КонецЕсли;
						стр_н.ЗначениеЧисло = эл.Значение;
						стр_н.Значение = XMLСтрока(стр_н.ЗначениеЧисло);
					КонецЦикла;
					ВыполнитьАвтоклассификациюФрагмент(СвойстваСправочника, СобытиеЗамераОбъект);
				КонецЕсли;
				СобытиеЗамераОбъект.Записать();
			КонецЦикла;
		КонецЕсли;
		
		// Обновление инфорации о количестве прочитанных строк
		РегистрыСведений.СостояниеЧтения.УстановитьСостояние(
			ФайлЗамера, 
			ДатаНачалаЧтения,
			ПрочитаноСтрок, 
			ДатаНачалаЧтения,
			РазмерФайла,
			ДатаПрочитанныхДанных);
		
	КонецЦикла;
	    		
		
КонецФункции

Процедура ВыполнитьАвтоклассификациюФрагмент(Знач СвойстваСправочника, СобытиеЗамераОбъект)
	// поле всего
	КоличествоВсего = 0;
	Свойство = СправочникиСерверПовтИсп.ПолучитьСвойствоПоИмениСинониму("Total","Total",СвойстваСправочника);
	строка_всего = Неопределено;
	Для каждого стр из СобытиеЗамераОбъект.КлючевыеСвойства Цикл
		Если стр.Свойство=Свойство Тогда
			строка_всего = стр;
		Иначе
			КоличествоВсего = КоличествоВсего + стр.ЗначениеЧисло;
		КонецЕсли;
	КонецЦикла;	
	Если строка_всего=Неопределено Тогда
		строка_всего = СобытиеЗамераОбъект.КлючевыеСвойства.Добавить();
		строка_всего.Свойство = Свойство;
	КонецЕсли;
	строка_всего.ЗначениеЧисло = КоличествоВсего;
	строка_всего.Значение = XMLСтрока(строка_всего.ЗначениеЧисло);
КонецПроцедуры
	
Функция ПриобразоватьВремяКИнтервалу(Знач ГруппировкаПоВремени, Знач ДатаСобытия)
	
	ДатаИнтервала = НачалоЧаса(ДатаСобытия);
	Интервал = Минута(ДатаСобытия);
	
	Если ГруппировкаПоВремени="1_час" Тогда
		ДатаИнтервала = НачалоЧаса(ДатаСобытия);	
	ИначеЕсли ГруппировкаПоВремени="30_мин" Тогда
		Интервал = Окр(Интервал/30,0,РежимОкругления.Окр15как10);
		ДатаИнтервала=ДатаИнтервала+Интервал*30*60;
	ИначеЕсли ГруппировкаПоВремени="15_мин" Тогда
		Интервал = Окр(Интервал/15,0,РежимОкругления.Окр15как10);
		ДатаИнтервала=ДатаИнтервала+Интервал*15*60;
	ИначеЕсли ГруппировкаПоВремени="10_мин" Тогда
		Интервал = Окр(Интервал/10,0,РежимОкругления.Окр15как10);
		ДатаИнтервала=ДатаИнтервала+Интервал*10*60;
	ИначеЕсли ГруппировкаПоВремени="5_мин" Тогда
		Интервал = Окр(Интервал/5,0,РежимОкругления.Окр15как10);
		ДатаИнтервала=ДатаИнтервала+Интервал*5*60;
	Иначе
		ДатаИнтервала = НачалоМинуты(ДатаСобытия);
	КонецЕсли;
	
	Возврат ДатаИнтервала;
	
КонецФункции

Процедура ЗаписатьРезультатРегистрКлассификации(Знач Выборка, Знач Замер, Знач КлассОсновной, Знач КлассВторичный, Знач КосинусОсновной, Знач КосинусВторичный, Знач СохранятьВторойКласс)
	
	Перем МенеджерЗаписи;
	
	МенеджерЗаписи = РегистрыСведений.КлассификаторДанных.СоздатьМенеджерЗаписи();
	МенеджерЗаписи.Ключ = Замер;
	МенеджерЗаписи.Основной = Истина;
	МенеджерЗаписи.ДатаСобытия = Выборка.ДатаСобытия;
	МенеджерЗаписи.СобытиеЗамера =  Выборка.СобытиеЗамера;
	МенеджерЗаписи.Свойство = Выборка.Свойство;
	МенеджерЗаписи.Кластер = КлассОсновной;
	МенеджерЗаписи.Косинус = КосинусОсновной;
	МенеджерЗаписи.Записать();
	Если НЕ КлассВторичный=Неопределено И СохранятьВторойКласс=Истина Тогда
		МенеджерЗаписи = РегистрыСведений.КлассификаторДанных.СоздатьМенеджерЗаписи();
		МенеджерЗаписи.Ключ = Замер;
		МенеджерЗаписи.Основной = Ложь;
		МенеджерЗаписи.ДатаСобытия = Выборка.ДатаСобытия;
		МенеджерЗаписи.СобытиеЗамера =  Выборка.СобытиеЗамера;
		МенеджерЗаписи.Свойство = Выборка.Свойство;
		МенеджерЗаписи.Кластер = КлассВторичный;
		МенеджерЗаписи.Косинус = КосинусВторичный;
		МенеджерЗаписи.Записать();
	КонецЕсли;

КонецПроцедуры

Процедура ЗаписатьРезультатИсходныйЗамер(Знач Выборка, Знач Замер, Знач КлассОсновной, Знач КосинусОсновной)
	
	Если НЕ ЗначениеЗаполнено(Выборка.СобытиеЗамера) Тогда
		Возврат;
	КонецЕсли;
	СобытиеЗамера = Выборка.СобытиеЗамера.ПолучитьОбъект();
	
	Свойство = СправочникиСерверПовтИсп.ПолучитьСвойствоПоИмениСинониму("decision","decision");
	мОтбор = Новый Структура("Свойство",Свойство);
	н_строки = СобытиеЗамера.КлючевыеСвойства.НайтиСтроки(мОтбор);
	
	Если н_строки.Количество()>0 Тогда
		стр_н = н_строки[0];
	Иначе
		стр_н = СобытиеЗамера.КлючевыеСвойства.Добавить();
	КонецЕсли;
	
	стр_н.Свойство = Свойство;
	стр_н.Значение = КлассОсновной;
	стр_н.ЗначениеЧисло = КосинусОсновной;
	
	СобытиеЗамера.ОбменДанными.Загрузка=Истина;
	СобытиеЗамера.Записать();

КонецПроцедуры

	
Функция СформироватьВекторСловСписком(БазисСлов)
	// вектор списка значений
	ВекторСловСписком = новый СписокЗначений;
	
	Для каждого Слово из БазисСлов Цикл
		Структура = новый Структура("Слово,Количество,КоличествоСлов,КоличествоДокументовЭтоСлово,TF,IDF,TFIDF,Значение",Слово.Слово,0,0,0,0,0,0,0);
		ЗаполнитьЗначенияСвойств(Структура,Слово);
		ВекторСловСписком.Добавить(Структура,Слово.Слово);
	КонецЦикла;
	// отсортируем
	ВекторСловСписком.СортироватьПоЗначению(НаправлениеСортировки.Возр);
	
	Если ВекторСловСписком.Количество()=0 Тогда
		ВызватьИсключение "Вектор для автоматической классификации не задан! Выполните настройки!";
	КонецЕсли;
	
	Возврат ВекторСловСписком;
КонецФункции
	
Функция ПолучитьВекторЗапроса(Текст,КоличествоДокументов,мНастройка)
	
	ВекторЗапроса = новый Массив;
	
	// 1. Разберем слово
	ОбработаннаяСтрокаЗапроса = ОбработатьТекстДанных(Текст,мНастройка);
	// 2. Составим вектор
	ОбработаннаяСтрокаЗапроса = СтрЗаменить(ОбработаннаяСтрокаЗапроса,Символы.ПС," ");
	//ОбработаннаяСтрокаЗапроса = УдалитьСловаНеВходящиеВБазис(ОбработаннаяСтрокаЗапроса);
	МассивСлов = СтрРазделить(ОбработаннаяСтрокаЗапроса," ",Ложь);
	
	КоличествоСловЗапроса = МассивСлов.Количество();
	Если КоличествоДокументов=0 Тогда
		КоличествоДокументов=1;
	КонецЕсли;
	КешВажностиСлов = новый Соответствие;
	
	Для каждого стр из мНастройка.ТаблицаВажностиСлов Цикл
		КешВажностиСлов.Вставить(стр.Слово,стр);
	КонецЦикла; 	
	
	Для каждого эл из мНастройка.ВекторСловСписком Цикл
		стр = эл.Значение;
		
		Точка = новый Структура("Слово,Количество,КоличествоСлов,TF,IDF,TFIDF,Значение",стр.Слово,0,0,0,0,0,0);
		
		КоличествоВхождений = СтрЧислоВхождений(" "+ОбработаннаяСтрокаЗапроса+" "," "+стр.Слово+" ");		
		
		Если КоличествоВхождений>0 Тогда
			
			стрВажность = КешВажностиСлов.Получить(стр.Слово);
			Важность=1;
			Если НЕ стрВажность=Неопределено Тогда
				Важность = стрВажность.Важность;
			КонецЕсли;
			
			Точка.Количество = КоличествоВхождений;
			Точка.TF = Важность*КоличествоВхождений/КоличествоСловЗапроса;			
			Если стр.КоличествоДокументовЭтоСлово=0 Тогда
				стр.КоличествоДокументовЭтоСлово=1;
			КонецЕсли;			
			Точка.IDF =  Log10(КоличествоДокументов/стр.КоличествоДокументовЭтоСлово);
			Точка.TFIDF = Точка.IDF*Точка.TF;
			Точка.Значение = Точка.TFIDF;
		КонецЕсли;
		
		ВекторЗапроса.Добавить(Точка);
		
	КонецЦикла;	
	
	Возврат ВекторЗапроса;
	
КонецФункции

Функция ПолучитьТекстЗапросаКлассификатора()
	ТекстЗапроса = "ВЫБРАТЬ
	|	ИзвестныеСитуации.Ссылка КАК Ссылка,
	|	ИзвестныеСитуации.Родитель КАК Родитель,
	|	ИзвестныеСитуации.Наименование КАК Наименование,
	|	ИзвестныеСитуации.Текст КАК Текст,
	|	ИзвестныеСитуации.НижняяГраница КАК НижняяГраница
	|ИЗ
	|	Справочник.ИзвестныеСитуации КАК ИзвестныеСитуации
	|ГДЕ
	|	ИзвестныеСитуации.Ссылка В ИЕРАРХИИ(&Корень)
	|	И НЕ ИзвестныеСитуации.Ссылка = &Корень
	|
	|УПОРЯДОЧИТЬ ПО
	|	Ссылка ИЕРАРХИЯ";
	
	Возврат ТекстЗапроса;
КонецФункции

Функция ПолучитьТекстЗапросаВыборки()
	
	ТекстЗапроса = "ВЫБРАТЬ ПЕРВЫЕ 200
	|	КС.Ссылка КАК СобытиеЗамера,
	|	КС.Свойство КАК Свойство,
	|	КС.Значение КАК Текст,
	|	КС.Ссылка.ДатаСобытия КАК ДатаСобытия
	|ИЗ
	|	Справочник.СобытияЗамера.КлючевыеСвойства КАК КС
	|ГДЕ
	|	(КС.Ссылка.Владелец = &Замер
	|	И КС.Свойство = &Свойство)
	|	И НЕ КС.Свойство.ЧисловойРежим
	|	И (ВЫРАЗИТЬ(КС.Значение КАК СТРОКА(100))) <> """"
	|	И КС.Ссылка.ДатаСобытия > &ДатаСобытия
	|УПОРЯДОЧИТЬ ПО
	|	ДатаСобытия";	
	
	Возврат ТекстЗапроса;
КонецФункции

#КонецОбласти

#Область Математика

// Функция - Получить косинус между двумя векторами
//
// Параметры:
//  вхВектор1	 - список значений/массив - первый вектор
//  вхВектор2	 - список значений/массив - второй вектор
// 
// Возвращаемое значение:
// число  - результат перемножения векторов, если у одного (обоих) векторов длина равно 0 (нулевой вектор), то резултат будет -999999999.
//
Функция ПолучитьКосинусВекторов(вхВектор1, Ключ1, вхВектор2, Ключ2, мКешПараметры)
	
	Косинус = 0;
	
	Вектор1 = мКешПараметры.КешДанныхСжатыхВекторов.Получить(Ключ1);
	Если Вектор1=Неопределено Тогда
		Если ТипЗнч(вхВектор1)=Тип("СписокЗначений") Тогда
			Вектор1 = вхВектор1.ВыгрузитьЗначения();
		Иначе
			Вектор1 = вхВектор1;
		КонецЕсли;
		Если НЕ Ключ1=Неопределено Тогда
			мКешПараметры.КешДанныхСжатыхВекторов.Вставить(Ключ1,Вектор1);
		КонецЕсли;
	КонецЕсли;
	
	Вектор2 = мКешПараметры.КешДанныхСжатыхВекторов.Получить(Ключ2);
	Если Вектор2=Неопределено Тогда
		Если ТипЗнч(вхВектор2)=Тип("СписокЗначений") Тогда
			Вектор2 = вхВектор2.ВыгрузитьЗначения();
		Иначе
			Вектор2 = вхВектор2;
		КонецЕсли;			
		Если НЕ Ключ2=Неопределено Тогда
			мКешПараметры.КешДанныхСжатыхВекторов.Вставить(Ключ2,Вектор2);
		КонецЕсли;
	КонецЕсли;
	
	ПроизведениеВекторов = 0;
	
	// оптимизация
	СжатыйВектор1 = мКешПараметры.КешСжатыхВекторов.Получить(Ключ1);
	Если СжатыйВектор1=Неопределено Тогда
		СжатыйВектор1 = СжатьВектор(Вектор1,Ключ1);
		Если НЕ Ключ1=Неопределено Тогда
			мКешПараметры.КешСжатыхВекторов.Вставить(Ключ1,СжатыйВектор1);
		КонецЕсли;
	КонецЕсли;
	СжатыйВектор2 = мКешПараметры.КешСжатыхВекторов.Получить(Ключ2);
	Если СжатыйВектор2=Неопределено Тогда
		СжатыйВектор2 = СжатьВектор(Вектор2,Ключ2);
		Если НЕ Ключ2=Неопределено Тогда
			мКешПараметры.КешСжатыхВекторов.Вставить(Ключ2,СжатыйВектор2);
		КонецЕсли;
	КонецЕсли;
	
	ДлинаВектор1 = ПолучитьДлинуВектора(СжатыйВектор1,Ключ1,мКешПараметры);
	ДлинаВектор2 = ПолучитьДлинуВектора(СжатыйВектор2,Ключ2,мКешПараметры);
	
	Если ДлинаВектор1=0 ИЛИ ДлинаВектор2=0 Тогда
		Возврат -999999999;
	КонецЕсли;
	                  	
	
	БольшийВектор = Неопределено;
	МенишийВектор = Неопределено;
	Если СжатыйВектор1.Количество()>СжатыйВектор2.Количество() Тогда
		МенишийВектор=СжатыйВектор2;
		БольшийВектор=СжатыйВектор1;
	Иначе
		МенишийВектор=СжатыйВектор1;
		БольшийВектор=СжатыйВектор2;
	КонецЕсли;
	
	Для каждого ш из МенишийВектор Цикл
		ж = БольшийВектор.Получить(ш.Ключ);
		Если ж=Неопределено Тогда
			Продолжить;
		КонецЕсли;
		ПроизведениеВекторов = ПроизведениеВекторов + ш.Значение*ж;
	КонецЦикла;
	
	Косинус = Окр(ПроизведениеВекторов/(ДлинаВектор1*ДлинаВектор2),5,РежимОкругления.Окр15как20);
	
	Возврат Косинус;
	
КонецФункции

Функция ПолучитьДлинуВектора(Знач Вектор1, Знач Ключ, мКешПараметры)
	
	ДлинаВектора = Неопределено;
	Если НЕ Ключ=Неопределено Тогда
		ДлинаВектора = мКешПараметры.КешРасчетныхДанных.Получить(Ключ);
	КонецЕсли;
	
	Если ДлинаВектора=Неопределено Тогда	
		ДлинаВектора= 0;
		Для каждого стр из Вектор1 Цикл
			ДлинаВектора = ДлинаВектора+стр.Значение*стр.Значение;
		КонецЦикла;
		ДлинаВектора = Окр(ДлинаВектора,5,РежимОкругления.Окр15как20);
		Если НЕ Ключ=Неопределено Тогда
			мКешПараметры.КешРасчетныхДанных.Вставить(Ключ,ДлинаВектора);
		КонецЕсли;
	Конецесли;
	
	Возврат  Sqrt(ДлинаВектора);
	
КонецФункции

Функция СжатьВектор(Вектор,Ключ)
	СжатыйВекторРезультат = новый Соответствие;
	
	Для ш=0 по Вектор.Количество()-1 Цикл
		Если Вектор[ш].Значение=0 Тогда
			Продолжить;
		КонецЕсли;
		СжатыйВекторРезультат.Вставить(ш,Вектор[ш].Значение);
	КонецЦикла;
	
	Возврат СжатыйВекторРезультат;
КонецФункции

#КонецОбласти

#Область ОбработкаТекста

Функция ОбработатьТекстДанных(Знач ВходнойТекст,Знач мПараметры)
	
	// удалим переносы и другие символы
	ДанныеТекст = ВходнойТекст;
	
	Если мПараметры.ОбработкаТекста.Текст_РазделятьБольшойМаленький Тогда
		ДанныеТекст = Текст_ОбработатьТекстRegExpReplaceМальнькаяЗаглавная(ДанныеТекст);
	КонецЕсли; 
	
	ДанныеТекст = нрег(ДанныеТекст);
	
	Если мПараметры.ОбработкаТекста.Текст_ЗаменитьСинонимы=Истина Тогда
		ДанныеТекст = Текст_ОбработатьЗаменитьСинонимыИзТекста(ДанныеТекст,мПараметры.ФразыСинонимы);
	КонецЕсли;	
	Если мПараметры.ОбработкаТекста.Текст_УдалятьСтопФразы=Истина Тогда
		ДанныеТекст = Текст_УдалитьСтопФразыИзТекста(ДанныеТекст,мПараметры.СтопФразы);
	КонецЕсли;	
	Если мПараметры.ОбработкаТекста.Текст_УдалятьНомерДатаДокумента=Истина Тогда
		ДанныеТекст = Текст_ОбработатьНомерДатаДокумента(ДанныеТекст);
	КонецЕсли;
	Если мПараметры.ОбработкаТекста.Текст_УдалятьCPP Тогда
		ДанныеТекст = Текст_ОбработатьТекстRegExpReplaceCPP(ДанныеТекст);
	КонецЕсли;
	Если мПараметры.ОбработкаТекста.Текст_УдалятьServerAddr Тогда
		ДанныеТекст = Текст_ОбработатьТекстRegExpReplaceServerAddr(ДанныеТекст);
	КонецЕсли;	
	Если мПараметры.ОбработкаТекста.Текст_УдалятьURL Тогда
		ДанныеТекст = Текст_ОбработатьТекстRegExpReplaceURL(ДанныеТекст);
	КонецЕсли;	
	Если мПараметры.ОбработкаТекста.Текст_УдалятьКомментарииКода Тогда
		ДанныеТекст = Текст_ОбработатьТекстRegExpReplaceCodeComment(ДанныеТекст);
	КонецЕсли;	
	Если мПараметры.ОбработкаТекста.Текст_УдалятьПараметрыSQLЗапросов Тогда
		ДанныеТекст = Текст_ОбработатьТекстRegExpReplaceSqlParam(ДанныеТекст);
		ДанныеТекст = Текст_ОбработатьТекстRegExpReplaceHRESULT(ДанныеТекст);
	КонецЕсли;	
	Если мПараметры.ОбработкаТекста.Текст_УдалятьСтекВызова Тогда
		ДанныеТекст = Текст_ОбработатьТекстRegExpReplaceСтекВызова(ДанныеТекст);
	КонецЕсли;
	Если мПараметры.ОбработкаТекста.Текст_УдалятьОшибкаКРесурсу Тогда
		ДанныеТекст = Текст_ОбработатьТекстRegExpReplaceОшибкаПриВвыполненииЗапросаКРесурсу(ДанныеТекст);
	КонецЕсли;
	
	ДанныеТекст = СтрЗаменить(ДанныеТекст,".cpp","_cpp");
	ДанныеТекст = СтрЗаменить(ДанныеТекст,"."," "+Символы.ПС);
	ДанныеТекст = СтрЗаменить(ДанныеТекст,"/","_");
	ДанныеТекст = СтрЗаменить(ДанныеТекст,"\","_");
	ДанныеТекст = СтрЗаменить(ДанныеТекст,"["," ");
	ДанныеТекст = СтрЗаменить(ДанныеТекст,"]"," ");
	
	// удалим гуиды
	ДанныеТекст = Текст_ОбработатьТекстRegExpReplaceUUID(ДанныеТекст);
	
	ДанныеТекст = Текст_ОбработатьТекстRegExp(ДанныеТекст,Истина,Истина);
	Если мПараметры.ОбработкаТекста.Текст_УдалятьЦифры Тогда
		ДанныеТекст = Текст_ОбработатьТекстRegExpУдалитьЦифры(ДанныеТекст);
	КонецЕсли;
	
	Если мПараметры.ОбработкаТекста.Текст_УдалятьСтопСлова=Истина Тогда
		ДанныеТекст = Текст_УдалитьСтопСловаИзТекста(ДанныеТекст,мПараметры.СтопСлова);
	КонецЕсли;
	
	// в нижний формат
	ДанныеТекст = Нрег(ДанныеТекст);
	
	Если мПараметры.ОбработкаТекста.Текст_ЗаменитьСинонимы=Истина Тогда
		ДанныеТекст = Текст_ОбработатьЗаменитьСинонимыИзТекста(ДанныеТекст,мПараметры.ФразыСинонимы);
	КонецЕсли;	
	Если мПараметры.ОбработкаТекста.Текст_УдалятьСтопФразы=Истина Тогда
		ДанныеТекст = Текст_УдалитьСтопФразыИзТекста(ДанныеТекст,мПараметры.СтопФразы);
	КонецЕсли;
	
	// Стеммер Портера используется для обработки массива данных, т.к. очень накладно
	Если мПараметры.ОбработкаТекста.Текст_ИспользоватьСтеммерПортера=Истина Тогда
		ТекстДляРазбора = СтрЗаменить(ДанныеТекст,Символы.ПС," ");
		МассивСлов = СтрРазделить(ТекстДляРазбора," ",Ложь);
		МассивСлов = ОбработатьМассивАлгоритмомСтемминг(МассивСлов);
		ДанныеТекст = СтрСоединить(МассивСлов," ");
		ДанныеТекст = СтрЗаменить(ДанныеТекст,нрег("END_OF_TEXT_PARAGRAF"),Символы.ПС+нрег("END_OF_TEXT_PARAGRAF")+Символы.ПС);
	КонецЕсли;
		
	Возврат ДанныеТекст;

КонецФункции

#Область REGEXPR

Функция Текст_ОбработатьТекстRegExp(Знач Текст,ОставитьЧисла=Ложь,Перенос=Ложь)
	RegExp=Новый COMОбъект("VBScript.RegExp");
	RegExp.MultiLine=Истина; 
	RegExp.Global=Истина;
	Паттерн = "[^A-zА-я ";
	
	Если ОставитьЧисла Тогда
		Паттерн = Паттерн + "0-9";
	КонецЕсли;
	
	Если Перенос Тогда
		Паттерн = Паттерн +Символы.ПС;
	КонецЕсли;
	
	Паттерн = Паттерн+"]";
	
	RegExp.Pattern = Паттерн;
	
	Res = RegExp.Replace(Текст, " ");
	Возврат Res;  
КонецФункции

Функция Текст_ОбработатьТекстRegExpУдалитьЦифры(Знач Текст)

	RegExp=Новый COMОбъект("VBScript.RegExp");
	RegExp.MultiLine=Истина; 
	RegExp.Global=Истина;
	Паттерн = "\b([0-9]{1,10})\b";
	Паттерн = "\b0[xX][0-9a-fA-F]+|[0-9]{1,10}\b";
	
	
	RegExp.Pattern = Паттерн;
	
	Res = RegExp.Replace(Текст, " ");
	Возврат Res;  
КонецФункции

Функция Текст_ОбработатьТекстRegExpReplaceUUID(Знач Текст)

	RegExp=Новый COMОбъект("VBScript.RegExp");
	RegExp.MultiLine=Истина; 
	RegExp.Global=Истина;
	RegExp.IgnoreCase=Истина;
	Паттерн = "\b[0-9a-f]{8}\b-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-\b[0-9a-f]{12}\b";
	
	
	RegExp.Pattern = Паттерн;
	
	Res = RegExp.Replace(Текст, " ");
	Возврат Res;  
КонецФункции

Функция Текст_ОбработатьТекстRegExpReplaceIPV6(Знач Текст)

	RegExp=Новый COMОбъект("VBScript.RegExp");
	RegExp.MultiLine=Истина; 
	RegExp.Global=Истина;
	Паттерн = "((^|:)([0-9a-fA-F]{0,4})){1,8}";
	
	
	RegExp.Pattern = Паттерн;
	
	Res = RegExp.Replace(Текст, " ");
	Возврат Res;  
КонецФункции

Функция Текст_ОбработатьТекстRegExpReplaceIPV4(Знач Текст)

	RegExp=Новый COMОбъект("VBScript.RegExp");
	RegExp.MultiLine=Истина; 
	RegExp.Global=Истина;
	RegExp.IgnoreCase=Истина;
	Паттерн = "([0-9]{1,3}[\.]){3}[0-9]{1,3}";
	
	
	RegExp.Pattern = Паттерн;
	
	Res = RegExp.Replace(Текст, " ");
	Возврат Res;  
КонецФункции

Функция Текст_ОбработатьТекстRegExpReplaceCPP(Знач Текст)

	RegExp=Новый COMОбъект("VBScript.RegExp");
	RegExp.MultiLine=Истина; 
	RegExp.Global=Истина;
	RegExp.IgnoreCase=Истина;
	Паттерн = "file=.*\.cpp|src.*\.cpp|:\\jenkins.*(\.cpp)|.:\\.*\.h";
	
	RegExp.Pattern = Паттерн;
	
	Res = RegExp.Replace(Текст, " ");
	Возврат Res;  
КонецФункции

Функция Текст_ОбработатьНомерДатаДокумента(Знач Текст)

	RegExp=Новый COMОбъект("VBScript.RegExp");
	RegExp.MultiLine=Истина; 
	RegExp.Global=Истина;
	RegExp.IgnoreCase=Истина;
	Паттерн = "\s[0-9]{1,2}([a-z]|[а-я]){1,2}-[0-9].*[0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}";
	
	RegExp.Pattern = Паттерн;
	
	Res = RegExp.Replace(Текст, " ");
	Возврат Res;  
КонецФункции

Функция Текст_ОбработатьТекстRegExpReplaceServerAddr(Знач Текст)

	RegExp=Новый COMОбъект("VBScript.RegExp");
	RegExp.MultiLine=Истина; 
	RegExp.Global=Истина;
	RegExp.IgnoreCase=Истина;
	Паттерн = "server_addr.*descr.*\):";
	
	
	RegExp.Pattern = Паттерн;
	
	Res = RegExp.Replace(Текст, " ");
	Возврат Res;  
КонецФункции

Функция Текст_ОбработатьТекстRegExpReplaceURL(Знач Текст)

	RegExp=Новый COMОбъект("VBScript.RegExp");
	RegExp.MultiLine=Истина; 
	RegExp.Global=Истина;
	RegExp.IgnoreCase=Истина;
	Паттерн = "http://.*\b|https://.*\b";
	
	
	RegExp.Pattern = Паттерн;
	
	Res = RegExp.Replace(Текст, " ");
	Возврат Res;  
КонецФункции

Функция Текст_ОбработатьТекстRegExpReplaceCodeComment(Знач Текст)

	RegExp=Новый COMОбъект("VBScript.RegExp");
	RegExp.MultiLine=Истина; 
	RegExp.Global=Истина;
	RegExp.IgnoreCase=Истина;
	Паттерн = "\s//.*(\b|\s)$";
	
	
	RegExp.Pattern = Паттерн;
	
	Res = RegExp.Replace(Текст, " ");
	Возврат Res;  
КонецФункции

Функция Текст_ОбработатьТекстRegExpReplaceSqlParam(Знач Текст)

	RegExp=Новый COMОбъект("VBScript.RegExp");
	RegExp.MultiLine=Истина; 
	RegExp.Global=Истина;
	Паттерн = "p_[0-9]{1,10}.*(\b|\s)";
	
	
	RegExp.Pattern = Паттерн;
	
	Res = RegExp.Replace(Текст, " ");
	Возврат Res;  
КонецФункции

Функция Текст_ОбработатьТекстRegExpReplaceHRESULT(Знач Текст)

	RegExp=Новый COMОбъект("VBScript.RegExp");
	RegExp.MultiLine=Истина; 
	RegExp.Global=Истина;
	RegExp.IgnoreCase=Истина;
	Паттерн = "\bHRESULT.*\b";
	
	
	RegExp.Pattern = Паттерн;
	
	Res = RegExp.Replace(Текст, " ");
	Возврат Res;  
КонецФункции

Функция Текст_ОбработатьТекстRegExpReplaceСтекВызова(Знач Текст)

	RegExp=Новый COMОбъект("VBScript.RegExp");
	RegExp.MultiLine=Истина; 
	RegExp.Global=Истина;
	RegExp.IgnoreCase=Истина;
	//Паттерн = "\{.*\(.*\).*\}:.*(\b|\s)";
	Паттерн = "\{.*\([^,|\s|\b]*\).*\}:.*(\b|\s)";
	
	
	RegExp.Pattern = Паттерн;
	
	Res = RegExp.Replace(Текст, " ");
	Возврат Res;  
КонецФункции

Функция Текст_ОбработатьТекстRegExpReplaceОшибкаПриВвыполненииЗапросаКРесурсу(Знач Текст)

	RegExp=Новый COMОбъект("VBScript.RegExp");
	RegExp.MultiLine=Истина; 
	RegExp.Global=Истина;
	RegExp.IgnoreCase=Истина;
	Паттерн = "(Ошибка|Error).*(POST|GET).*:(\b|\s)";
	
	
	RegExp.Pattern = Паттерн;
	
	Res = RegExp.Replace(Текст, " ");
	Возврат Res;  
КонецФункции

Функция Текст_ОбработатьТекстRegExpReplaceМальнькаяЗаглавная(Знач Текст)

	RegExp=Новый COMОбъект("VBScript.RegExp");
	RegExp.MultiLine=Ложь; 
	RegExp.Global=Истина;
	
	// разбивает маленькаяБольша
	Паттерн = "([а-яё])([А-ЯЁ])";	
	RegExp.Pattern = Паттерн;
	
	Текст = RegExp.Replace(Текст, "$1 $2");
	
	// разбивает smallBig
	Паттерн = "([a-z])([A-Z])";	
	RegExp.Pattern = Паттерн;
	
	Текст = RegExp.Replace(Текст, "$1 $2");
	
	// разбивает маленькаяBig
	Паттерн = "([a-z])([А-ЯЁ])";	
	RegExp.Pattern = Паттерн;
	
	Текст = RegExp.Replace(Текст, "$1 $2");
	
	// разбивает smallБольшая
	Паттерн = "([а-яё])([A-Z])";	
	RegExp.Pattern = Паттерн;
	
	Текст = RegExp.Replace(Текст, "$1 $2");
	
	Возврат Текст;  
КонецФункции

#КонецОбласти

Функция ОбработатьМассивАлгоритмомСтемминг(МассивСлов)
	
	ОбработанныйМассивСлов = новый Массив;
	
	МассивКУдалению = новый Массив;
	Для каждого стр из МассивСлов Цикл
		Стеммер = СтеммерПортераКлиентСерверПовтИсп.ПрименитьСтеммерПортера(стр);
		ОбработанныйМассивСлов.Добавить(Стеммер);
	КонецЦикла;
	
	Возврат ОбработанныйМассивСлов;
КонецФункции


#Область СтопСлова

Функция ПолучитьФразыСинонимы(Текст)
	
	ТекстФразыСинонимы = нрег(Текст);
	МассивФразСинонимов = СтрРазделить(ТекстФразыСинонимы,Символы.ПС,Ложь);
	
	Возврат МассивФразСинонимов;
КонецФункции

Функция ПолучитьСтопФразы(Текст)
	
	ТекстСтопФразы = нрег(Текст);
	МассивСтопФраз = СтрРазделить(ТекстСтопФразы,Символы.ПС,Ложь);

	Возврат МассивСтопФраз;
	
КонецФункции

Функция ПолучитьСтопСлов(Текст)
	
	КешСтопСлов = новый Соответствие;
	ТекстСтопСлова = нрег(Текст);
	ТекстСтопСлова = СтрЗаменить(ТекстСтопСлова," ",Символы.ПС);
	МассивСтопСлов = СтрРазделить(ТекстСтопСлова,Символы.ПС,Ложь);
	
	Для каждого стр из МассивСтопСлов Цикл
		стр = СокрЛП(стр);
		КешСтопСлов.Вставить(стр,стр);
	КонецЦикла;
	
	Возврат КешСтопСлов;
	
КонецФункции

Функция Текст_УдалитьСтопСловаИзТекста(Знач Текст,Знач СтопСлова)
	
	ТекстБезСтопСлов = "";
	
	
	// разбиваем на слова
	МассивСловТекста = СтрРазделить(Текст," ", Ложь);
	
	// объединяем обратно                                     ,
	Для каждого слово из МассивСловТекста Цикл
		
		Если НЕ ЗначениеЗаполнено(слово) Тогда
			Продолжить;
		КонецЕсли;
		
		слово = СокрЛП(слово);
		
		Если НЕ СтопСлова.Получить(нрег(слово))=Неопределено Тогда
			Продолжить;
		КонецЕсли;	
		
		
		Если нрег(слово)="end_of_text_paragraf" Тогда
			ТекстБезСтопСлов = ТекстБезСтопСлов + Символы.ПС + слово+" " + Символы.ПС;
		Иначе
			ТекстБезСтопСлов = ТекстБезСтопСлов + слово+" ";
		КонецЕсли;
	КонецЦикла;
	
	Возврат ТекстБезСтопСлов;
КонецФункции

Функция Текст_УдалитьСтопФразыИзТекста(Знач Текст,Знач СтопФразы)
	
	ТекстБезСтопФраз = Текст;	
	
	Для каждого фраза из СтопФразы Цикл
		ТекстБезСтопФраз = СтрЗаменить(ТекстБезСтопФраз,фраза," ");
	КонецЦикла;
	
	Возврат ТекстБезСтопФраз;
КонецФункции

Функция Текст_ОбработатьЗаменитьСинонимыИзТекста(Знач Текст,Знач ФразыСинонимы)
	
	ТекстБезСинонимовФраз = Текст;
	
	
	Для каждого фраза из ФразыСинонимы Цикл
		Массив = СтрРазделить(фраза,"#",Ложь);
		Если Массив.Количество()<2 Тогда
			Продолжить;
		КонецЕсли;
		ТекстБезСинонимовФраз = СтрЗаменить(ТекстБезСинонимовФраз,СокрЛП(Массив[0]),СокрЛП(Массив[1]));
	КонецЦикла;
	
	Возврат ТекстБезСинонимовФраз;
КонецФункции

#КонецОбласти

Функция ПолучитьМакетНаСервере(ИмяМакета)
	Макет = Неопределено;
	Попытка
		Макет = ЭтотОбъект.ПолучитьМакет(ИмяМакета);
	Исключение
		Сообщить(ОписаниеОшибки());		
	КонецПопытки;
	Возврат Макет;
КонецФункции

#КонецОбласти