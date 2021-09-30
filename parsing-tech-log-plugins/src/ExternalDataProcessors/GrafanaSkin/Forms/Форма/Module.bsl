&НаКлиенте
Перем КешПараметров;

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	//Вставить содержимое обработчика
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	КешПараметров = новый Соответствие;
	
	// по времени группировка
	ГруппировкаПоВремени="НетГруппировки";

	// позиция диаграммы
	Элементы.ПозицияДиаграммы.СписокВыбора.Добавить("Ряд1Лево","ряд 1 лево");
	Элементы.ПозицияДиаграммы.СписокВыбора.Добавить("Ряд2Лево","ряд 2 лево");
	Элементы.ПозицияДиаграммы.СписокВыбора.Добавить("Ряд3Лево","ряд 3 лево");
	Элементы.ПозицияДиаграммы.СписокВыбора.Добавить("Ряд1Право","ряд 1 право");
	Элементы.ПозицияДиаграммы.СписокВыбора.Добавить("Ряд2Право","ряд 2 право");
	Элементы.ПозицияДиаграммы.СписокВыбора.Добавить("Ряд3Право","ряд 3 право");
	Если НЕ ЗначениеЗаполнено(ПозицияДиаграммы) Тогда
		ПозицияДиаграммы = "Ряд1Лево";
	КонецЕсли;
	
	Для каждого стр из Элементы.ПозицияДиаграммы.СписокВыбора Цикл
		Элементы.ТаблицаИсточниковИзБазыПозицияДиаграммы.СписокВыбора.Добавить(стр.Значение,стр.Представление);
	КонецЦикла;
	
	// автообновление
	Элементы.ИнтервалАвтообновления.СписокВыбора.Добавить(0,"не использовать");
	Элементы.ИнтервалАвтообновления.СписокВыбора.Добавить(10,"10 с");
	Элементы.ИнтервалАвтообновления.СписокВыбора.Добавить(15,"15 с");
	Элементы.ИнтервалАвтообновления.СписокВыбора.Добавить(20,"20 с");
	Элементы.ИнтервалАвтообновления.СписокВыбора.Добавить(30,"30 с");
	Элементы.ИнтервалАвтообновления.СписокВыбора.Добавить(60,"60 с");
	Элементы.ИнтервалАвтообновления.СписокВыбора.Добавить(120,"2 мин");
	
	
	Элементы.ГотовыеВариантыИнтервалИзБазы.СписокВыбора.Добавить(300,"5 мин");
	Элементы.ГотовыеВариантыИнтервалИзБазы.СписокВыбора.Добавить(600,"10 мин");
	Элементы.ГотовыеВариантыИнтервалИзБазы.СписокВыбора.Добавить(1200,"20 мин");
	Элементы.ГотовыеВариантыИнтервалИзБазы.СписокВыбора.Добавить(1800,"30 мин");
	Элементы.ГотовыеВариантыИнтервалИзБазы.СписокВыбора.Добавить(3600,"1 ч");
	Элементы.ГотовыеВариантыИнтервалИзБазы.СписокВыбора.Добавить(5400,"1 ч 30 мин");
	Элементы.ГотовыеВариантыИнтервалИзБазы.СписокВыбора.Добавить(7200,"2 ч");
	Элементы.ГотовыеВариантыИнтервалИзБазы.СписокВыбора.Добавить(10800,"3 ч");
	Элементы.ГотовыеВариантыИнтервалИзБазы.СписокВыбора.Добавить(14400,"4 ч");
	Элементы.ГотовыеВариантыИнтервалИзБазы.СписокВыбора.Добавить(18000,"5 ч");
	Элементы.ГотовыеВариантыИнтервалИзБазы.СписокВыбора.Добавить(21000,"6 ч");
	Элементы.ГотовыеВариантыИнтервалИзБазы.СписокВыбора.Добавить(43200,"12 ч");
	Элементы.ГотовыеВариантыИнтервалИзБазы.СписокВыбора.Добавить(86400,"24 ч");
	Элементы.ГотовыеВариантыИнтервалИзБазы.СписокВыбора.Добавить(172800,"48 ч");
	Элементы.ГотовыеВариантыИнтервалИзБазы.СписокВыбора.Добавить(0,"произвольный");	
	
	Для каждого стр из Элементы.ГотовыеВариантыИнтервалИзБазы.СписокВыбора Цикл
		Элементы.ГотовыеВариантыИнтервалИзБазы1.СписокВыбора.Добавить(стр.Значение,стр.Представление);
	КонецЦикла;
	
	Если ИнтервалИзБазы=0 Тогда
		ИнтервалИзБазы=3600;
		ГотовыеВариантыИнтервалИзБазы=3600;
	КонецЕсли;
	
	// Быстрый скролл
	Элементы.БыстрыйСкроллОкна.СписокВыбора.Добавить(-3600,"<1 ч");
	Элементы.БыстрыйСкроллОкна.СписокВыбора.Добавить(-1800,"<30 мин");
	Элементы.БыстрыйСкроллОкна.СписокВыбора.Добавить(-600,"<10 мин");
//	Элементы.БыстрыйСкроллОкна.СписокВыбора.Добавить(-300,"<5 мин");
//	Элементы.БыстрыйСкроллОкна.СписокВыбора.Добавить(0,"0");
//	Элементы.БыстрыйСкроллОкна.СписокВыбора.Добавить(300,"5 мин>");
	Элементы.БыстрыйСкроллОкна.СписокВыбора.Добавить(600,"10 мин>");
	Элементы.БыстрыйСкроллОкна.СписокВыбора.Добавить(1800,"30 мин>");
	Элементы.БыстрыйСкроллОкна.СписокВыбора.Добавить(3600,"1 ч>");
	
	// тип линий
	Элементы.ТаблицаИсточниковИзБазыТипЛинии.СписокВыбора.Добавить("Сплошная","Сплошная");
	Элементы.ТаблицаИсточниковИзБазыТипЛинии.СписокВыбора.Добавить("Пунктир","Пунктир");
	Элементы.ТаблицаИсточниковИзБазыТипЛинии.СписокВыбора.Добавить("ПунктирТочка","Пунктир Точка");
	Элементы.ТаблицаИсточниковИзБазыТипЛинии.СписокВыбора.Добавить("ПунктирТочкаТочка","Пунктир Точка Точка");
	Элементы.ТаблицаИсточниковИзБазыТипЛинии.СписокВыбора.Добавить("Точечная","Точечная");
	
	// легенда
	Элементы.ПозицияРасположенияЛегенды.СписокВыбора.Добавить("нет","нет");
	Элементы.ПозицияРасположенияЛегенды.СписокВыбора.Добавить("низ","низ");
	Элементы.ПозицияРасположенияЛегенды.СписокВыбора.Добавить("верх","верх");
	Элементы.ПозицияРасположенияЛегенды.СписокВыбора.Добавить("право","право");
	Элементы.ПозицияРасположенияЛегенды.СписокВыбора.Добавить("лево","лево");
	
	Если НЕ ЗначениеЗаполнено(ПозицияРасположенияЛегенды) Тогда
		ПозицияРасположенияЛегенды="низ";
	КонецЕсли;
	
	// пустое
	Элементы.НазваниеСхемы.СписокВыбора.Добавить("загрузка ...");
	
	ОбновитьСписокВыбораЭкранов();
	ГотовыеВариантыИнтервалИзБазыВидимость();
	ОбновитьВидимостьДиаграмм();
	ОбновитьОформлениеПоТекущейТеме();
	ИзменитьВидимостьЭкрановПоУсловиюНастройки(ИспользоватьНесколькоЭкранов);
	ОбновитьГрафикИсторииКлиент(ДатаСобытияИзБазы,ИнтервалИзБазы);	
	
	// откроем настройку, если все пусто
	Если ТаблицаИсточниковИзБазы.Количество()=0 Тогда
		Элементы.Страницы.ТекущаяСтраница=Элементы.СтраницаНастройка;
	Иначе
		ИнтервалАвтообновленияПриИзменении(Неопределено);
	КонецЕсли;
	
	// автозагрузим данные, если не стоит обратное
	Если НЕ НеЗагружатьАвтоматическиСхемуПриОткрытии=Истина Тогда
		Если ЗначениеЗаполнено(НазваниеСхемы) Тогда
			ЗагрузитьИзОбщихНастроек(Неопределено);
		КонецЕсли;
	КонецЕсли;
	
	// при открытии обновим по текущей дате
	Если НЕ ИнтервалАвтообновления=0 Тогда
		ДатаСобытияИзБазы=ТекущаяДата();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьОформлениеПоТекущейТеме()
	
	Если Ложь И ПользователиВызовСервера.ПолучитьИмяТекущегоГлавногоСтиля()="Темный" Тогда
		
		КешВидимыхДиаграмм = новый Соответствие();
		КешВидимыхДиаграмм.Вставить("Ряд1Лево",Ложь);
		КешВидимыхДиаграмм.Вставить("Ряд2Лево",Ложь);
		КешВидимыхДиаграмм.Вставить("Ряд3Лево",Ложь);
		КешВидимыхДиаграмм.Вставить("Ряд1Право",Ложь);
		КешВидимыхДиаграмм.Вставить("Ряд2Право",Ложь);
		КешВидимыхДиаграмм.Вставить("Ряд3Право",Ложь);
		
		Для каждого стр из КешВидимыхДиаграмм Цикл
			      			
			ЭтаФорма["ДиаграммаДанныхИзБазы"+стр.Ключ].Окантовка = Ложь;
			
			ЭтаФорма["ДиаграммаДанныхИзБазы"+стр.Ключ].ОписаниеПалитрыЦветов.ПалитраЦветов = ПалитраЦветовДиаграммы.Яркая;
			
			// Проставляем темный фон, светлый шрифт
			ЭтаФорма["ДиаграммаДанныхИзБазы"+стр.Ключ].ОбластьПостроения.ПрозрачныйФон = Истина;
			ЭтаФорма["ДиаграммаДанныхИзБазы"+стр.Ключ].ЦветФона = Новый Цвет(80, 80, 80);
			ЭтаФорма["ДиаграммаДанныхИзБазы"+стр.Ключ].ОбластьЛегенды.ЦветТекста = Новый Цвет(200, 200, 200); 
			ЭтаФорма["ДиаграммаДанныхИзБазы"+стр.Ключ].ОбластьПостроения.ЦветТекста = Новый Цвет(200, 200, 200);
			ЭтаФорма["ДиаграммаДанныхИзБазы"+стр.Ключ].ОбластьПостроения.ЦветШкал = Новый Цвет(150, 150, 150);			
			
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьВидимостьДиаграмм()
	
	КешВидимыхДиаграмм = новый Соответствие();
	КешВидимыхДиаграмм.Вставить("Ряд1Лево",Ложь);
	КешВидимыхДиаграмм.Вставить("Ряд2Лево",Ложь);
	КешВидимыхДиаграмм.Вставить("Ряд3Лево",Ложь);
	КешВидимыхДиаграмм.Вставить("Ряд1Право",Ложь);
	КешВидимыхДиаграмм.Вставить("Ряд2Право",Ложь);
	КешВидимыхДиаграмм.Вставить("Ряд3Право",Ложь);
	Для каждого стр из ТаблицаИсточниковИзБазы Цикл
		Если (ИспользоватьНесколькоЭкранов=Истина 
			И стр.Выбрана=Истина И стр.Экран=ТекущийЭкран)
			ИЛИ  (ИспользоватьНесколькоЭкранов=Ложь И стр.Выбрана=Истина) Тогда
			КешВидимыхДиаграмм.Вставить(стр.ПозицияДиаграммы,Истина);
		КонецЕсли;
	КонецЦикла;
	
	Для каждого стр из КешВидимыхДиаграмм Цикл
		Элементы["ДиаграммаДанныхИзБазы"+стр.Ключ].Видимость = стр.Значение;
	КонецЦикла;
	
КонецПроцедуры

#Область ОбработкаСобытийЭлементов

&НаКлиенте
Процедура ТаблицаЭкранновЭкранПриИзменении(Элемент)
	// нужно переименовать экраны ссылки
КонецПроцедуры


&НаКлиенте
Процедура ТекущийЭкранПриИзменении(Элемент)
	
	Для каждого стр из ТаблицаЭкраннов Цикл
		Если стр.Экран=ТекущийЭкран Тогда
			Если НЕ ЗначениеЗаполнено(стр.Заголовок) Тогда
				Заголовок = стр.Экран;
			Иначе
				Заголовок = стр.Заголовок;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	ОбновитьВидимостьДиаграмм();
	ОбновитьГрафикИсторииКлиент(ДатаСобытияИзБазы,ИнтервалИзБазы);
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаЭкранновПриИзменении(Элемент)
	Для каждого стр из ТаблицаЭкраннов Цикл
		Если НЕ ЗначениеЗаполнено(стр.Заголовок) И ЗначениеЗаполнено(стр.Экран) Тогда
			стр.Заголовок = стр.Экран;
		КонецЕсли;
	КонецЦикла;
	ОбновитьСписокВыбораЭкранов();
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьСписокВыбораЭкранов()
	Элементы.ТекущийЭкран.СписокВыбора.Очистить();
	Элементы.ТаблицаИсточниковИзБазыЭкран.СписокВыбора.Очистить();
	Для каждого стр из ТаблицаЭкраннов Цикл
		Элементы.ТекущийЭкран.СписокВыбора.Добавить(стр.Экран);
		Элементы.ТаблицаИсточниковИзБазыЭкран.СписокВыбора.Добавить(стр.Экран);
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура СтраницыПриСменеСтраницы(Элемент, ТекущаяСтраница)
	Если ТекущаяСтраница=Элементы.СтраницаДиаграммы Тогда
		ОбновитьВидимостьДиаграмм();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ГотовыеВариантыИнтервалИзБазыПриИзменении(Элемент)
	ГотовыеВариантыИнтервалИзБазыВидимость();
	ОбновитьГрафикИсторииКлиент(ДатаСобытияИзБазы,ИнтервалИзБазы);
КонецПроцедуры

&НаКлиенте
Процедура ГотовыеВариантыИнтервалИзБазыВидимость()
	Если ГотовыеВариантыИнтервалИзБазы=0 Тогда
		Элементы.ИнтервалИзБазы.Видимость=Истина;
	Иначе
		ИнтервалИзБазы = ГотовыеВариантыИнтервалИзБазы;
		Элементы.ИнтервалИзБазы.Видимость=Ложь;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура БыстрыйСкроллОкнаПриИзменении(Элемент)
	ДатаСобытияИзБазы = ДатаСобытияИзБазы+БыстрыйСкроллОкна;
	ОбновитьГрафикИсторииКлиент(ДатаСобытияИзБазы,ИнтервалИзБазы);
	БыстрыйСкроллОкна = 0;
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаИсточниковИзБазыПриИзменении(Элемент)
	Для каждого стр из ТаблицаИсточниковИзБазы Цикл
		Если НЕ ЗначениеЗаполнено(стр.Представление) 
			И ЗначениеЗаполнено(стр.Свойство)
			И ЗначениеЗаполнено(стр.Замер) Тогда
			стр.Представление = Строка(стр.Свойство)+" ("+Строка(стр.Замер)+")";
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ДатаСобытияИзБазыПриИзменении(Элемент)
	ОбновитьГрафикИсторииКлиент(ДатаСобытияИзБазы,ИнтервалИзБазы);
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаИсточниковИзБазыПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаИсточниковИзБазыПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	ТекущиеДанные = Элемент.ТекущиеДанные;
	Если НоваяСтрока=Истина Тогда
		ТекущиеДанные.ПозицияДиаграммы = ПозицияДиаграммы;
	КонецЕсли;
	ТекущиеДанные.ТипЛинии="Сплошная";
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьДиаграммуДанныхИзБазы(Команда)
	Элементы.Страницы.ТекущаяСтраница=Элементы.СтраницаДиаграммы;
	ОбновитьГрафикИсторииКлиент(ДатаСобытияИзБазы,ИнтервалИзБазы);
КонецПроцедуры


&НаКлиенте
Процедура ИнтервалАвтообновленияПриИзменении(Элемент)
	Если ИнтервалАвтообновления=0 Тогда
		ОтключитьОбработчикОжидания("АвтообновлениеГрафикМониторинга");
	Иначе
		ПодключитьОбработчикОжидания("АвтообновлениеГрафикМониторинга",ИнтервалАвтообновления,Ложь );
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура АвтообновлениеГрафикМониторинга() Экспорт
	// не обновляем, если экран настройки
	Если НЕ Элементы.Страницы.ТекущаяСтраница=Элементы.СтраницаДиаграммы Тогда
		Возврат;
	КонецЕсли;
	ДатаСобытияИзБазы=ТекущаяДата();
	ОбновитьГрафикИсторииКлиент(ДатаСобытияИзБазы,ИнтервалИзБазы);
КонецПроцедуры

#КонецОбласти

#Область ОбновитьГрафик

&НаКлиенте
Процедура ОбновитьГрафикИсторииКлиент(ДатаОкончания,Интервал)
	
	Если Интервал=0 Тогда
		Интервал = 600;
	КонецЕсли;
	
	Если ДатаОкончания=Дата(1,1,1) Тогда
		ДатаОкончания = ТекущаяДата();
	КонецЕсли;
	
	ДатаНачала = ДатаОкончания-Интервал;
	
	КешПараметров.Вставить("ПредИнтервалНачало",КешПараметров.Получить("ИнтервалНачало"));
	КешПараметров.Вставить("ПредИнтервалОкончание",КешПараметров.Получить("ИнтервалОкончание"));
	
	КешПараметров.Вставить("ИнтервалНачало",ДатаНачала);
	КешПараметров.Вставить("ИнтервалОкончание",ДатаОкончания);
	
	ОбновитьГрафикИсторииСервер(ДатаНачала,ДатаОкончания);
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьГрафикИсторииСервер(ДатаНачала,ДатаОкончания)
	
	ВремяНачала = ТекущаяДата();
	Если ИспользоватьНесколькоЭкранов=Истина Тогда
		мОтбор = Новый  Структура("Выбрана,Экран",Истина,ТекущийЭкран);
	Иначе
		мОтбор = Новый  Структура("Выбрана",Истина);
	КонецЕсли;
	ТаблицаЗамеров = ТаблицаИсточниковИзБазы.Выгрузить(ТаблицаИсточниковИзБазы.НайтиСтроки(мОтбор),);
	КешЧеловеческихПредставлений = Новый Соответствие();
	КешДублей = Новый Соответствие;
	Для каждого стр из ТаблицаЗамеров Цикл
		Ключ_UUID = строка(новый UUID());
		КоличествоДублей = КешДублей.Получить(стр.Представление);
		Если КоличествоДублей=Неопределено Тогда
			КешЧеловеческихПредставлений.Вставить(Ключ_UUID,стр.Представление);
			КешДублей.Вставить(стр.Представление,1);
		Иначе
			КешЧеловеческихПредставлений.Вставить(Ключ_UUID,стр.Представление+" дубль-"+КоличествоДублей);
			КешДублей.Вставить(стр.Представление,КоличествоДублей+1);
		КонецЕсли;
		стр.Представление = Ключ_UUID;
	КонецЦикла;
	
	//ДиаграммаДанныхИзБазы.Очистить();
	//ДиаграммаДанныхИзБазы = новый Диаграмма;
	//ДиаграммаДанныхИзБазы.ПалитраЦветов=ПалитраЦветовДиаграммы.Авто;
	
	//УстановитьПозициюЛегендыДиаграммы(ДиаграммаДанныхИзБазы);

	

	
	// настройка диаграммы
	Для каждого стр из ТаблицаЗамеров Цикл
		ЭтаФорма["ДиаграммаДанныхИзБазы"+стр.ПозицияДиаграммы].Очистить();
		УстановитьПозициюЛегендыДиаграммы(ЭтаФорма["ДиаграммаДанныхИзБазы"+стр.ПозицияДиаграммы],ПозицияРасположенияЛегенды);
		УстановитьТипДиаграммы(ЭтаФорма["ДиаграммаДанныхИзБазы"+стр.ПозицияДиаграммы],"График");
		УстановитьРежимСглаживанияДиаграммы(ЭтаФорма["ДиаграммаДанныхИзБазы"+стр.ПозицияДиаграммы],СглаживатьЛинии);
	КонецЦикла;



	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	ВЫРАЗИТЬ(ТЗ.Представление КАК СТРОКА(150)) КАК Представление,
	|	ВЫРАЗИТЬ(ТЗ.Замер КАК Справочник.Замеры) КАК Замер,
	|	ВЫРАЗИТЬ(ТЗ.Свойство КАК Справочник.Свойства) КАК Свойство,
	|	ВЫРАЗИТЬ(ТЗ.Смещение КАК ЧИСЛО(10, 0)) КАК Смещение,
	|	ВЫРАЗИТЬ(ТЗ.ТипСобытия КАК Справочник.События) КАК ТипСобытия,
	|	ВЫРАЗИТЬ(ТЗ.Ключ КАК Справочник.КлючиСобытия) КАК Ключ
	|ПОМЕСТИТЬ ВтТЗ
	|ИЗ
	|	&ТЗ КАК ТЗ
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Замер,
	|	Свойство,
	|	ТипСобытия,
	|	Ключ
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВтТЗ.Представление КАК Представление,
	|	Т.ЗначениеЧисло КАК ЗначениеЧисло,
	|	Т.Ссылка.ДатаСобытия КАК ДатаСобытия
	|ИЗ
	|	Справочник.СобытияЗамера.КлючевыеСвойства КАК Т
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВтТЗ КАК ВтТЗ
	|		ПО Т.Ссылка.Владелец = ВтТЗ.Замер
	|			И Т.Свойство = ВтТЗ.Свойство
	|			И Т.Ссылка.ТипСобытия = ВтТЗ.ТипСобытия
	|			И Т.Ссылка.Ключ = ВтТЗ.Ключ
	|			И ВтТЗ.Смещение = 0	
	|ГДЕ
	|	(Т.Ссылка.Владелец, Т.Свойство, Т.Ссылка.ТипСобытия, Т.Ссылка.Ключ) В
	|			(ВЫБРАТЬ
	|				Т.Замер,
	|				Т.Свойство,
	|				Т.ТипСобытия,
	|				Т.Ключ
	|			ИЗ
	|				ВтТЗ КАК Т)
	|	И Т.Ссылка.НомерСтрокиФайла = 0
	|   И Т.Ссылка.ДатаСобытия МЕЖДУ &ДатаНачала И &ДатаОкончания
	|
	|   И &ГРУППИРОВКА1
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ВтТЗ.Представление КАК Представление,
	|	Т.ЗначениеЧисло КАК ЗначениеЧисло,
	|   &ДатаСобытия2 КАК ДатаСобытия
	|ИЗ
	|	Справочник.СобытияЗамера.КлючевыеСвойства КАК Т
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВтТЗ КАК ВтТЗ
	|		ПО Т.Ссылка.Владелец = ВтТЗ.Замер
	|			И Т.Свойство = ВтТЗ.Свойство
	|			И Т.Ссылка.ТипСобытия = ВтТЗ.ТипСобытия
	|			И Т.Ссылка.Ключ = ВтТЗ.Ключ
	|			И ВтТЗ.Смещение > 0	
	|ГДЕ
	|	(Т.Ссылка.Владелец, Т.Свойство, Т.Ссылка.ТипСобытия, Т.Ссылка.Ключ) В
	|			(ВЫБРАТЬ
	|				Т.Замер,
	|				Т.Свойство,
	|				Т.ТипСобытия,
	|				Т.Ключ
	|			ИЗ
	|				ВтТЗ КАК Т)
	|	И Т.Ссылка.НомерСтрокиФайла = 0
	|	И ВЫБОР
	|			КОГДА ВтТЗ.Смещение = 60
	|				ТОГДА ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 60)
	|			КОГДА ВтТЗ.Смещение = 300
	|				ТОГДА ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 300)
	|			КОГДА ВтТЗ.Смещение = 600
	|				ТОГДА ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 600)
	|			КОГДА ВтТЗ.Смещение = 1800
	|				ТОГДА ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 1800)
	|			КОГДА ВтТЗ.Смещение = 3600
	|				ТОГДА ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 3600)
	|			КОГДА ВтТЗ.Смещение = 43200
	|				ТОГДА ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 43200)
	|			КОГДА ВтТЗ.Смещение = 86400
	|				ТОГДА ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 86400)
	|			КОГДА ВтТЗ.Смещение = 172800
	|				ТОГДА ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 172800)
	|			ИНАЧЕ Т.Ссылка.ДатаСобытия
	|		КОНЕЦ МЕЖДУ &ДатаНачала И &ДатаОкончания
	|
	|   И &ГРУППИРОВКА2
	|
	|УПОРЯДОЧИТЬ ПО
	|	ДатаСобытия";	
	
	
	
	Если НЕ ГруппировкаПоВремени="НетГруппировки" Тогда
		
		Запрос.Текст = СтрЗаменить(Запрос.Текст,"Т.ЗначениеЧисло КАК ЗначениеЧисло,","СРЕДНЕЕ(Т.ЗначениеЧисло) КАК ЗначениеЧисло,");	
		Если ГруппировкаПоВремени="Группировка1Час" Тогда 
			// дата
			Запрос.Текст = СтрЗаменить(Запрос.Текст,"Т.Ссылка.ДатаСобытия КАК ДатаСобытия","НАЧАЛОПЕРИОДА(Т.Ссылка.ДатаСобытия,ЧАС) КАК ДатаСобытия");
			Запрос.Текст = СтрЗаменить(Запрос.Текст,"&ДатаСобытия2",	
			"	ВЫБОР
			|		КОГДА ВтТЗ.Смещение = 60
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 60),ЧАС)
			|		КОГДА ВтТЗ.Смещение = 300
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 300),ЧАС)
			|		КОГДА ВтТЗ.Смещение = 600
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 600),ЧАС)
			|		КОГДА ВтТЗ.Смещение = 1800
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 1800),ЧАС)
			|		КОГДА ВтТЗ.Смещение = 3600
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 3600),ЧАС)
			|		КОГДА ВтТЗ.Смещение = 43200
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 43200),ЧАС)
			|		КОГДА ВтТЗ.Смещение = 86400
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 86400),ЧАС)
			|		КОГДА ВтТЗ.Смещение = 172800
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 172800),ЧАС)
			|		ИНАЧЕ Т.Ссылка.ДатаСобытия
			|	КОНЕЦ");			
			
			// группировка
			Запрос.Текст = СтрЗаменить(Запрос.Текст,"И &ГРУППИРОВКА1",
			"СГРУППИРОВАТЬ ПО 
			|	ВтТЗ.Представление,
			|	НАЧАЛОПЕРИОДА(Т.Ссылка.ДатаСобытия,ЧАС)");
			Запрос.Текст = СтрЗаменить(Запрос.Текст,"И &ГРУППИРОВКА2",
			"СГРУППИРОВАТЬ ПО 
			|	ВтТЗ.Представление,
			|	ВЫБОР
			|		КОГДА ВтТЗ.Смещение = 60
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 60),ЧАС)
			|		КОГДА ВтТЗ.Смещение = 300
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 300),ЧАС)
			|		КОГДА ВтТЗ.Смещение = 600
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 600),ЧАС)
			|		КОГДА ВтТЗ.Смещение = 1800
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 1800),ЧАС)
			|		КОГДА ВтТЗ.Смещение = 3600
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 3600),ЧАС)
			|		КОГДА ВтТЗ.Смещение = 43200
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 43200),ЧАС)
			|		КОГДА ВтТЗ.Смещение = 86400
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 86400),ЧАС)
			|		КОГДА ВтТЗ.Смещение = 172800
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 172800),ЧАС)
			|		ИНАЧЕ Т.Ссылка.ДатаСобытия
			|	КОНЕЦ");
		ИначеЕсли ГруппировкаПоВремени="Группировка1Мин" Тогда 
			// дата
			Запрос.Текст = СтрЗаменить(Запрос.Текст,"Т.Ссылка.ДатаСобытия КАК ДатаСобытия","НАЧАЛОПЕРИОДА(Т.Ссылка.ДатаСобытия,МИНУТА) КАК ДатаСобытия");			
			Запрос.Текст = СтрЗаменить(Запрос.Текст,"&ДатаСобытия2",	
			"	ВЫБОР
			|		КОГДА ВтТЗ.Смещение = 60
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 60),МИНУТА)
			|		КОГДА ВтТЗ.Смещение = 300
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 300),МИНУТА)
			|		КОГДА ВтТЗ.Смещение = 600
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 600),МИНУТА)
			|		КОГДА ВтТЗ.Смещение = 1800
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 1800),МИНУТА)
			|		КОГДА ВтТЗ.Смещение = 3600
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 3600),МИНУТА)
			|		КОГДА ВтТЗ.Смещение = 43200
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 43200),МИНУТА)
			|		КОГДА ВтТЗ.Смещение = 86400
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 86400),МИНУТА)
			|		КОГДА ВтТЗ.Смещение = 172800
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 172800),МИНУТА)
			|		ИНАЧЕ Т.Ссылка.ДатаСобытия
			|	КОНЕЦ");  			
			
			
			// группировка
			Запрос.Текст = СтрЗаменить(Запрос.Текст,"И &ГРУППИРОВКА1",
			"СГРУППИРОВАТЬ ПО 
			|	ВтТЗ.Представление,
			|	НАЧАЛОПЕРИОДА(Т.Ссылка.ДатаСобытия,МИНУТА)");
			Запрос.Текст = СтрЗаменить(Запрос.Текст,"И &ГРУППИРОВКА2",
			"СГРУППИРОВАТЬ ПО 
			|	ВтТЗ.Представление,
			|	ВЫБОР
			|		КОГДА ВтТЗ.Смещение = 60
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 60),МИНУТА)
			|		КОГДА ВтТЗ.Смещение = 300
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 300),МИНУТА)
			|		КОГДА ВтТЗ.Смещение = 600
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 600),МИНУТА)
			|		КОГДА ВтТЗ.Смещение = 1800
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 1800),МИНУТА)
			|		КОГДА ВтТЗ.Смещение = 3600
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 3600),МИНУТА)
			|		КОГДА ВтТЗ.Смещение = 43200
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 43200),МИНУТА)
			|		КОГДА ВтТЗ.Смещение = 86400
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 86400),МИНУТА)
			|		КОГДА ВтТЗ.Смещение = 172800
			|			ТОГДА НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 172800),МИНУТА)
			|		ИНАЧЕ Т.Ссылка.ДатаСобытия
			|	КОНЕЦ");
		КонецЕсли;		
	Иначе
		Запрос.Текст = СтрЗаменить(Запрос.Текст,"И &ГРУППИРОВКА1","");
		Запрос.Текст = СтрЗаменить(Запрос.Текст,"И &ГРУППИРОВКА2","");
		Запрос.Текст = СтрЗаменить(Запрос.Текст,"&ДатаСобытия2",	
			"	ВЫБОР
			|		КОГДА ВтТЗ.Смещение = 60
			|			ТОГДА ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 60)
			|		КОГДА ВтТЗ.Смещение = 300
			|			ТОГДА ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 300)
			|		КОГДА ВтТЗ.Смещение = 600
			|			ТОГДА ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 600)
			|		КОГДА ВтТЗ.Смещение = 1800
			|			ТОГДА ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 1800)
			|		КОГДА ВтТЗ.Смещение = 3600
			|			ТОГДА ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 3600)
			|		КОГДА ВтТЗ.Смещение = 43200
			|			ТОГДА ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 43200)
			|		КОГДА ВтТЗ.Смещение = 86400
			|			ТОГДА ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 86400)
			|		КОГДА ВтТЗ.Смещение = 172800
			|			ТОГДА ДОБАВИТЬКДАТЕ(Т.Ссылка.ДатаСобытия, СЕКУНДА, 172800)
			|		ИНАЧЕ Т.Ссылка.ДатаСобытия
			|	КОНЕЦ ");
		
	КонецЕсли;
	
	
	Запрос.УстановитьПараметр("ТЗ", ТаблицаЗамеров);
	Запрос.УстановитьПараметр("ДатаНачала", ДатаНачала);
	Запрос.УстановитьПараметр("ДатаОкончания", ДатаОкончания);
	//Запрос.УстановитьПараметр("Ключ", key);
	
	
	КешСерий = Новый Соответствие;
	КешКлючей = Новый Соответствие;
	МассивКлючей = Новый Массив;
	КешДиаграмм = Новый Соответствие;
	Для каждого стр из ТаблицаЗамеров Цикл
		МассивКлючей.Добавить(стр.Представление);
		СерияОкно=Неопределено;
		Диаграмма = ЭтаФорма["ДиаграммаДанныхИзБазы"+стр.ПозицияДиаграммы];
		СерияОкно = Диаграмма.УстановитьСерию(КешЧеловеческихПредставлений.Получить(стр.Представление));
		УстновитьТипЛинииСерииДиаграммы(СерияОкно,стр.ТипЛинии);
		СерияОкно.Маркер = ТипМаркераДиаграммы.Нет;
		КешДиаграмм.Вставить(стр.Представление,Диаграмма);
		КешСерий.Вставить(стр.Представление,СерияОкно);
		КешКлючей.Вставить(стр.Представление,стр.Представление);
	КонецЦикла;
	
	ТаблицаДанныхИзБазы =  Запрос.Выполнить().Выгрузить();
	
	//Сообщить("Время запроса: "+(ТекущаяДата()-ВремяНачала));
	
	КешПредыдущих = Новый Соответствие;
	ПредыдущаяДатаСобытия = Неопределено;
	Если ТаблицаДанныхИзБазы.Количество()>0 Тогда
		ПредыдущаяДатаСобытия = ТаблицаДанныхИзБазы[0].ДатаСобытия - Секунда(ТаблицаДанныхИзБазы[0].ДатаСобытия);
	КонецЕсли;
	
	МассивНомрированныйИзБазы = Новый Массив;
	СтруктураДанных = Новый Соответствие();
	ПредыдущаяСтруктураДанных = Новый Соответствие();
	КлючейПоДатаСобытия = 0;
	
	
	Для каждого стр_данных из ТаблицаДанныхИзБазы Цикл
		
		// округлим до минут
		ДатаСобытия = стр_данных.ДатаСобытия - Секунда(стр_данных.ДатаСобытия);
		
		ОбновитьГрафикИсторииКлиентФрагмент(ДатаСобытия, КлючейПоДатаСобытия, МассивКлючей, МассивНомрированныйИзБазы, ПредыдущаяДатаСобытия, ПредыдущаяСтруктураДанных, СтруктураДанных);
		
		Ключ = КешКлючей.Получить(СокрЛП(стр_данных.Представление));
		СтруктураДанных.Вставить(Ключ,стр_данных.ЗначениеЧисло);
		КлючейПоДатаСобытия = КлючейПоДатаСобытия+1;
		
	КонецЦикла;
	
	
	ОбновитьГрафикИсторииКлиентФрагмент(Неопределено, КлючейПоДатаСобытия, МассивКлючей, МассивНомрированныйИзБазы, ПредыдущаяДатаСобытия, ПредыдущаяСтруктураДанных, СтруктураДанных);
	
	//Сообщить("Время обработки: "+(ТекущаяДата()-ВремяНачала));
	
	// если первый из элементов пустой, тогда найдем последующий
	МассивПустых = новый Массив;
	ПрерватьЦикл = Ложь;
	СтруктураЗаполнения = Неопределено;
	Для каждого стр из МассивНомрированныйИзБазы Цикл
		
		ЕстьПустые = Ложь;
		
		Если ПрерватьЦикл = Истина Тогда			
			Если МассивПустых.Количество()>0 Тогда
				Для каждого стр_пуст из МассивПустых Цикл
					Для каждого стр_данных из стр_пуст.СтруктураДанных Цикл
						Если стр_данных.Значение=Неопределено Тогда
							стр_пуст.СтруктураДанных.Вставить(стр_данных.Ключ,СтруктураЗаполнения.СтруктураДанных.Получить(стр_данных.Ключ));
						КонецЕсли;
					КонецЦикла;					
				КонецЦикла;
			КонецЕсли;			
			Прервать;
		КонецЕсли;

			
		Для каждого стр_данных из стр.СтруктураДанных Цикл
			Если стр_данных.Значение=Неопределено Тогда
				МассивПустых.Добавить(стр);
				ЕстьПустые=Истина;
				Прервать;
			КонецЕсли;
		КонецЦикла;
		
		Если ЕстьПустые=Ложь Тогда 
			ПрерватьЦикл=Истина;			
			СтруктураЗаполнения = стр;
		КонецЕсли;
		
	КонецЦикла;

	//Сообщить("Время 2-й обработки: "+(ТекущаяДата()-ВремяНачала));
	
	ш=0;	
	Для каждого стр из МассивНомрированныйИзБазы Цикл
		ш=ш+1;
		Для каждого стр_дан из стр.СтруктураДанных Цикл
			
			// округлим до минут
			ДатаСобытия = стр.ДатаСобытия - Секунда(стр.ДатаСобытия);
			Ключ = стр_дан.Ключ;
			
			СерияОкно = КешСерий.Получить(Ключ);
			Диаграмма = КешДиаграмм.Получить(Ключ);
			Если НЕ СерияОкно=Неопределено И НЕ Диаграмма=Неопределено Тогда
				ТочкаДиаграммы = Диаграмма.УстановитьТочку(ДатаСобытия);
				Если ГотовыеВариантыИнтервалИзБазы<86400 Тогда 
					ТочкаДиаграммы.Текст = Формат(ДатаСобытия,"ДФ=HH:mm:ss");
				Иначе
					ТочкаДиаграммы.Текст = Формат(ДатаСобытия,"ДФ='dd.MM.yyyy HH:mm'");
				КонецЕсли;
				Если ш=МассивНомрированныйИзБазы.Количество() Тогда
					ТочкаДиаграммы.ПриоритетЦвета=Истина;
					ТочкаДиаграммы.Цвет=WebЦвета.АкварельноСиний; 
				КонецЕсли;
				// добавим значение	
				Диаграмма.УстановитьЗначение(ТочкаДиаграммы, СерияОкно, стр_дан.Значение);
			КонецЕсли;
			
		КонецЦикла;		
		
	КонецЦикла;
	
	
	// отобразим значение для последних точек
	ОтобразитьЗначенияПослденихТочек(ТаблицаЗамеров,КешДиаграмм,КешСерий);
	
	
	//Сообщить("Время отрисовки: "+(ТекущаяДата()-ВремяНачала));
	
	//АдресХранилищаДанныхИзБазы = ПоместитьВоВременноеХранилище(МассивНомрированныйИзБазы,ЭтаФорма.УникальныйИдентификатор);	
	
	//Сообщить("Время хранлище: "+(ТекущаяДата()-ВремяНачала));
	
КонецПроцедуры


&НаСервере
Процедура ОтобразитьЗначенияПослденихТочек(ТаблицаЗамеров,КешДиаграмм,КешСерий)
	
	КешИнфЛиний = Новый Соответствие;
	
	Для Каждого стр из ТаблицаЗамеров Цикл
		Диаграмма = КешДиаграмм.Получить(стр.Представление);
		Если НЕ Диаграмма=Неопределено Тогда
			МассивЛиний = Новый Массив;
			Для каждого лин из Диаграмма.ИнформационныеЛинииЗначений Цикл
				МассивЛиний.Добавить(лин);
				лин.Значение=0;
				лин.ТекстПодписи="";
			КонецЦикла;
			КешИнфЛиний.Вставить(стр.Представление,МассивЛиний);
		КонецЕсли;
	КонецЦикла;
	
	Для Каждого стр из ТаблицаЗамеров Цикл
		
		Диаграмма = КешДиаграмм.Получить(стр.Представление);
		СерияОкно = КешСерий.Получить(стр.Представление);
		
		Если НЕ Диаграмма=Неопределено И НЕ СерияОкно=Неопределено Тогда
			
			ИнформационнаяЛиния = Неопределено;
			МассивЛиний = КешИнфЛиний.Получить(стр.Представление);
			
			Если НЕ МассивЛиний=Неопределено Тогда
				Если МассивЛиний.Количество()>0 Тогда
					ИнформационнаяЛиния = МассивЛиний[0];
					МассивЛиний.Удалить(0);
				КонецЕсли;
			КонецЕсли;
			
			Если МассивЛиний=Неопределено ИЛИ ИнформационнаяЛиния=Неопределено Тогда			
				//Добавляем информационную линию для отображения текущего значения
				ИнформационнаяЛиния = Диаграмма.ИнформационныеЛинииЗначений.Добавить();
				ИнформационнаяЛиния.Линия = новый Линия(ТипЛинииДиаграммы.НетЛинии, 0);
				ИнформационнаяЛиния.ОбластьПодписи.Положение = ПоложениеПодписейКДиаграмме.ПравоВерх;				
			КонецЕсли;
			
			Если Диаграмма.Точки.Количество()>0 Тогда
				Точка = Диаграмма.Точки.Получить(Диаграмма.Точки.Количество()-1);
				Значение = Диаграмма.ПолучитьЗначение(Точка,СерияОкно);
				
				Если НЕ Значение.Значение=Неопределено Тогда
					ИнформационнаяЛиния.Значение = Значение.Значение;
				КонецЕсли;
				ИнформационнаяЛиния.ТекстПодписи = 
				Формат(Значение.Значение, Диаграмма.ОбластьПостроения.ШкалаЗначений.ФорматПодписей);
			КонецЕсли;
			
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьПозициюЛегендыДиаграммы(ДиаграммаДанных,Расположение)
	
	Если Расположение="нет" Тогда
		ДиаграммаДанных.ОбластьЛегенды.Расположение = РасположениеЛегендыДиаграммы.Нет;
	ИначеЕсли Расположение="низ" Тогда
		ДиаграммаДанных.ОбластьЛегенды.Расположение = РасположениеЛегендыДиаграммы.Низ;
	ИначеЕсли Расположение="верх" Тогда
		ДиаграммаДанных.ОбластьЛегенды.Расположение = РасположениеЛегендыДиаграммы.Верх;
	ИначеЕсли Расположение="право" Тогда
		ДиаграммаДанных.ОбластьЛегенды.Расположение = РасположениеЛегендыДиаграммы.Право;
	ИначеЕсли Расположение="лево" Тогда
		ДиаграммаДанных.ОбластьЛегенды.Расположение = РасположениеЛегендыДиаграммы.Лево;
	Иначе
		ДиаграммаДанных.ОбластьЛегенды.Расположение = РасположениеЛегендыДиаграммы.Авто;
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура УстановитьРежимСглаживанияДиаграммы(ДиаграммаДанных,Режим)
	
	Если Режим=Истина Тогда
		ДиаграммаДанных.РежимСглаживания = РежимСглаживанияДиаграммы.ГладкаяКривая;
	Иначе
		ДиаграммаДанных.РежимСглаживания = РежимСглаживанияДиаграммы.Нет;
	КонецЕсли;

КонецПроцедуры




&НаСервере
Процедура УстановитьТипДиаграммы(ДиаграммаДанных,Тип)
	
	Если Тип="ГрафикСОбластями" Тогда
		ДиаграммаДанных.ТипДиаграммы=ТипДиаграммы.ГрафикСОбластями;
	ИначеЕсли Тип="ГрафикПоШагам" Тогда
		ДиаграммаДанных.ТипДиаграммы=ТипДиаграммы.ГрафикПоШагам;
	ИначеЕсли Тип="ГрафикСОбластямиНормированный" Тогда
		ДиаграммаДанных.ТипДиаграммы=ТипДиаграммы.ГрафикСОбластямиНормированный;
	ИначеЕсли Тип="Гистограмма" Тогда
		ДиаграммаДанных.ТипДиаграммы=ТипДиаграммы.Гистограмма;
	Иначе
		ДиаграммаДанных.ТипДиаграммы=ТипДиаграммы.График;
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура УстновитьТипЛинииСерииДиаграммы(Серия,Тип)	
	
	Если Тип="Пунктир" Тогда
		ТипЛинии=ТипЛинииДиаграммы.Пунктир;
	ИначеЕсли Тип="ПунктирТочка" Тогда
		ТипЛинии=ТипЛинииДиаграммы.ПунктирТочка;
	ИначеЕсли Тип="ПунктирТочкаТочка" Тогда
		ТипЛинии=ТипЛинииДиаграммы.ПунктирТочкаТочка;
	ИначеЕсли Тип="Точечная" Тогда
		ТипЛинии=ТипЛинииДиаграммы.Точечная;
	Иначе
		ТипЛинии=ТипЛинииДиаграммы.Сплошная;
	КонецЕсли;

	Серия.Линия = Новый Линия(ТипЛинии, 2);
	
КонецПроцедуры


&НаСервере
Процедура ОбновитьГрафикИсторииКлиентФрагмент(Знач ДатаСобытия, КлючейПоДатаСобытия, Знач МассивКлючей, Знач МассивНомрированный, ПредыдущаяДатаСобытия, ПредыдущаяСтруктураДанных, СтруктураДанных)
	
	Перем стр;
	
	Если НЕ ПредыдущаяДатаСобытия = ДатаСобытия Тогда
		МассивНомрированный.Добавить(Новый Структура("ДатаСобытия,СтруктураДанных",ПредыдущаяДатаСобытия,СтруктураДанных));
		ПредыдущаяДатаСобытия = ДатаСобытия;
		//проставим если не было значений по свойству
		Если КлючейПоДатаСобытия<МассивКлючей.Количество() Тогда
			Для каждого стр из МассивКлючей Цикл 
				Если СтруктураДанных.Получить(стр)=Неопределено Тогда
					СтруктураДанных.Вставить(стр,ПредыдущаяСтруктураДанных.Получить(стр));
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
		ПредыдущаяСтруктураДанных = СтруктураДанных;			
		СтруктураДанных = Новый Соответствие();
		КлючейПоДатаСобытия = 0;
	КонецЕсли;

КонецПроцедуры


#конецОбласти

#Область СохранениеЗагрузка

&НаКлиенте
Процедура СохранитьВОбщиеНастройки(Команда)
	Если НЕ ЗначениеЗаполнено(НазваниеСхемы) Тогда
		Сообщить("Укажите название схемы для сохранения!");
		Возврат;
	КонецЕсли;
	мНастройка = новый Структура();
	мНастройка.Вставить("СглаживатьЛинии",СглаживатьЛинии);
	мНастройка.Вставить("ИспользоватьНесколькоЭкранов",ИспользоватьНесколькоЭкранов);
	мНастройка.Вставить("ПозицияДиаграммы",ПозицияДиаграммы);
	мНастройка.Вставить("ПозицияРасположенияЛегенды",ПозицияРасположенияЛегенды);
	мМассивСтруктур = новый Массив;
	Для каждого стр из ТаблицаИсточниковИзБазы Цикл
		стр_н = Новый Структура("Выбрана,Экран,ПозицияДиаграммы,Замер,Свойство,Представление,Смещение,ТипСобытия,Ключ,ТипЛинии");
		ЗаполнитьЗначенияСвойств(стр_н,стр);
		мМассивСтруктур.Добавить(стр_н);
	КонецЦикла;
	мНастройка.Вставить("ТаблицаИсточниковИзБазы",мМассивСтруктур);
	мМассивСтруктур = новый Массив;
	Для каждого стр из ТаблицаЭкраннов Цикл
		стр_н = Новый Структура("Экран,Заголовок");
		ЗаполнитьЗначенияСвойств(стр_н,стр);
		мМассивСтруктур.Добавить(стр_н);
	КонецЦикла;
	мНастройка.Вставить("ТаблицаЭкраннов",мМассивСтруктур);
	УправлениеХранилищемНастроекВызовСервера.ЗаписатьДанныеВБезопасноеХранилищеРасширенный("GrafanaSkin",мНастройка,"Общая настройка для 'Grafana Skin'",НазваниеСхемы);
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьИзОбщихНастроек(Команда)
	Если НЕ ЗначениеЗаполнено(НазваниеСхемы) Тогда
		Сообщить("Укажите название схемы для загрузки!");
		Возврат;
	КонецЕсли;
	мНастройка = УправлениеХранилищемНастроекВызовСервера.ДанныеИзБезопасногоХранилища("GrafanaSkin",НазваниеСхемы);
	Если мНастройка<>Неопределено Тогда
		СглаживатьЛинии 			 = мНастройка.СглаживатьЛинии;
		ИспользоватьНесколькоЭкранов = мНастройка.ИспользоватьНесколькоЭкранов;
		ПозицияДиаграммы 			 = мНастройка.ПозицияДиаграммы;
		ПозицияРасположенияЛегенды 	 = мНастройка.ПозицияРасположенияЛегенды;
		мМассивСтруктур = Новый Массив;
		Если мНастройка.Свойство("ТаблицаИсточниковИзБазы",мМассивСтруктур) Тогда
			ТаблицаИсточниковИзБазы.Очистить();
			Для каждого стр из мМассивСтруктур Цикл
				стр_н = ТаблицаИсточниковИзБазы.Добавить();
				ЗаполнитьЗначенияСвойств(стр_н, стр);
			КонецЦикла;
		КонецЕсли;
		Если мНастройка.Свойство("ТаблицаЭкраннов",мМассивСтруктур) Тогда
			ТаблицаЭкраннов.Очистить();
			ВыбранныйЭкранСуществует = Ложь;
			Для каждого стр из мМассивСтруктур Цикл
				стр_н = ТаблицаЭкраннов.Добавить();
				ЗаполнитьЗначенияСвойств(стр_н, стр);
				Если ТекущийЭкран=стр.Экран Тогда
					ВыбранныйЭкранСуществует=Истина;
				КонецЕсли;
			КонецЦикла;
			Если НЕ ВыбранныйЭкранСуществует=Истина И мМассивСтруктур.Количество()>0 Тогда
				ТекущийЭкран = мМассивСтруктур[0].Экран;
			КонецЕсли;
		КонецЕсли;
		ИзменитьВидимостьЭкрановПоУсловиюНастройки(ИспользоватьНесколькоЭкранов);
	Иначе
		Сообщить("В общих настройках нет сохраненного шаблона: "+НазваниеСхемы+"!");
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьСписокНазванийСхем()
	
	Схемы = ПолучитьДоступныйСписокСхем();
	Элементы.НазваниеСхемы.СписокВыбора.Очистить();
	Для каждого стр из Схемы Цикл
		Элементы.НазваниеСхемы.СписокВыбора.Добавить(стр);
	КонецЦикла;

КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьДоступныйСписокСхем()
	МассивСхем = новый Массив;
	
	Запрос = новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	Т.Ключ КАК Наименование,
	|	Т.Комментарий КАК Комментарий
	|ИЗ
	|	РегистрСведений.БезопасноеХранилищеДанных КАК Т
	|ГДЕ
	| Т.Владелец=&ИмяОбработки";
	//|	Т.Ключ ПОДОБНО ""%""+&Ключ+""%""
	//|	И ВЫРАЗИТЬ(Т.Владелец КАК Справочник.ДополнительныеОтчетыИОбработки).ИмяОбъекта = &ИмяОбъекта";
	Запрос.УстановитьПараметр("Схема","GrafanaSkin.Схема");
	Запрос.УстановитьПараметр("ИмяОбработки","GrafanaSkin");
	
	УстановитьПривилегированныйРежим(Истина);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		Наименование = СокрЛП(СтрЗаменить(Выборка.Наименование,"GrafanaSkin.Схема",""));
		МассивСхем.Добавить(Наименование);
	КонецЦикла;
	
	Возврат МассивСхем;
КонецФункции

&НаКлиенте
Процедура НазваниеСхемыНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ЗаполнитьСписокНазванийСхем();
	ОповещениеОЗакрытииНазванияСхемы = Новый ОписаниеОповещения("ОповещениеОЗакрытииНазванияСхемы",ЭтотОбъект,Неопределено);
	Элементы.НазваниеСхемы.СписокВыбора.ПоказатьВыборЭлемента(ОповещениеОЗакрытииНазванияСхемы,Неопределено,Неопределено);
	//Элементы.НазваниеСхемы.СписокВыбора.ПоказатьВыборИзСписка(ОповещениеОЗакрытииНазванияСхемы,Элементы.НазваниеСхемы.СписокВыбора,НазваниеСхемы);
КонецПроцедуры

&НаКлиенте
Процедура ОповещениеОЗакрытииНазванияСхемы(ВыбранныйЭлемент, ДополнительныеПараметры) Экспорт
	Если НЕ ВыбранныйЭлемент=Неопределено Тогда
		НазваниеСхемы = ВыбранныйЭлемент;
		ЗагрузитьИзОбщихНастроек(Неопределено);
		ОбновитьВидимостьДиаграмм();
		ОбновитьСписокВыбораЭкранов();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура НазваниеСхемыНачалоВыбораИзСписка(Элемент, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура НазваниеСхемыОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьНесколькоЭкрановПриИзменении(Элемент)
	ИзменитьВидимостьЭкрановПоУсловиюНастройки(ИспользоватьНесколькоЭкранов);
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьВидимостьЭкрановПоУсловиюНастройки(НесколькоЭкранов=Истина)
	Если НесколькоЭкранов=Истина Тогда
		Элементы.ТаблицаЭкраннов.Видимость=Истина;
		Элементы.ТекущийЭкран.Видимость=Истина;
		Элементы.ТаблицаИсточниковИзБазыЭкран.Видимость=Истина;
	Иначе
		Элементы.ТаблицаЭкраннов.Видимость=Ложь;
		Элементы.ТекущийЭкран.Видимость=Ложь;
		Элементы.ТаблицаИсточниковИзБазыЭкран.Видимость=Ложь;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуНастройка(Команда)
	Элементы.Страницы.ТекущаяСтраница=Элементы.СтраницаНастройка;
КонецПроцедуры

&НаКлиенте
Процедура ЗавершитьЗакрытьНастройку(Команда)
	Элементы.Страницы.ТекущаяСтраница=Элементы.СтраницаДиаграммы;
КонецПроцедуры


#КонецОбласти