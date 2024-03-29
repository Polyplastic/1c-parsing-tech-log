
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	//Вставить содержимое обработчика
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Если Первые=0 Тогда
		Первые=1000;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьРасчет(Команда)
	
	КешСвертки = Новый Соответствие;
	ВыполнитьРасчетСервер(КешСвертки);
	
	Для каждого стр из КешСвертки Цикл
		стр_н = ТаблицаОбработанныхСобытий.Добавить();
		ЗаполнитьЗначенияСвойств(стр_н,стр.Значение);
	КонецЦикла;
	
	Элементы.Страницы.ТекущаяСтраница = Элементы.СтраницаРезультат;
	
КонецПроцедуры     

&НаСервере
Процедура ВыполнитьРасчетСервер(КешСвертки)
	
	Для каждого стр из ТаблицаДанных Цикл		
		
		Хеш = Новый ХешированиеДанных(ХешФункция.MD5);	
		Хеш.Добавить(стр.Значение);
		ЗначениеХеш = Хеш.ХешСумма;     
		
		// нет
		Если ГруппировкаБезПериода=Истина Тогда		
			ДатаГрупировки = Дата('00010101');                                                     
			ОбновитьКешПоГруппировке(ЗначениеХеш, КешСвертки, стр, ДатаГрупировки, "Нет");
		КонецЕсли;
		
		// Год  
		Если ГруппировкаГод=Истина Тогда
			ДатаГрупировки = НачалоГода(стр.Дата);                                                     
			ОбновитьКешПоГруппировке(ЗначениеХеш, КешСвертки, стр, ДатаГрупировки, "Год");
		КонецЕсли;
		// Месяц  
		Если ГруппировкаМесяц=Истина Тогда
			ДатаГрупировки = НачалоМесяца(стр.Дата);                                                     
			ОбновитьКешПоГруппировке(ЗначениеХеш, КешСвертки, стр, ДатаГрупировки, "Месяц");
		КонецЕсли;
		// Неделя  
		Если ГруппировкаНеделя=Истина Тогда
			ДатаГрупировки = НачалоНедели(стр.Дата);                                                     
			ОбновитьКешПоГруппировке(ЗначениеХеш, КешСвертки, стр, ДатаГрупировки, "Неделя");
		КонецЕсли;
		// День  
		Если ГруппировкаДень=Истина Тогда
			ДатаГрупировки = НачалоДня(стр.Дата);                                                     
			ОбновитьКешПоГруппировке(ЗначениеХеш, КешСвертки, стр, ДатаГрупировки, "День");
		КонецЕсли;
		
	КонецЦикла; 
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьКешПоГруппировке(ЗначениеХеш, КешСвертки, Источник, ДатаГруппировки, ТипГруппировки="Нет")
	
	Перем Данные;
	
	Ключ = НРег(Строка(ЗначениеХеш)+"->"+ТипГруппировки+":"+ДатаГруппировки+" "+Источник.ЗначениеАналитика1+" "+Источник.ЗначениеАналитика2);
	Данные = КешСвертки.Получить(Ключ);
	Если Данные=Неопределено Тогда
		Данные = Новый Структура("КоличествоСовпадений,Хеш,Значение,ДатаПоследнейЗаписи,СобытиеЗамера",0,ЗначениеХеш,Источник.Значение,Источник.Дата,Источник.СобытиеЗамера);
		Данные.Вставить("ДатаГруппировки",ДатаГруппировки);
		Данные.Вставить("ТипГруппировки",ТипГруппировки);
		Данные.Вставить("ДлительностьМксМаксимум",Источник.ДлительностьМкс);
		Данные.Вставить("ДлительностьМксСумма",0);
		Данные.Вставить("Аналитика1",Источник.Аналитика1);
		Данные.Вставить("ЗначениеАналитика1",Источник.ЗначениеАналитика1);
		Данные.Вставить("Аналитика2",Источник.Аналитика2);
		Данные.Вставить("ЗначениеАналитика2",Источник.ЗначениеАналитика2);
		КешСвертки.Вставить(Ключ,Данные);
	КонецЕсли;
	
	Данные.КоличествоСовпадений = Данные.КоличествоСовпадений+1;
	Данные.ДлительностьМксСумма = Данные.ДлительностьМксСумма+Источник.ДлительностьМкс;
	Если Данные.ДатаПоследнейЗаписи<=Источник.Дата И НЕ Данные.СобытиеЗамера = Источник.СобытиеЗамера Тогда
		Данные.ДатаПоследнейЗаписи = Источник.Дата;
		Данные.СобытиеЗамера = Источник.СобытиеЗамера;
	КонецЕсли;     
	Если Данные.ДлительностьМксМаксимум<Источник.ДлительностьМкс Тогда
		Данные.ДлительностьМксМаксимум=Источник.ДлительностьМкс;
	КонецЕсли;

КонецПроцедуры



&НаСервере
Процедура ПолучитьДанныеНаСервере() 
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1000
	|	СобытияЗамераКлючевыеСвойства.Ссылка КАК СобытиеЗамера,
	|	СобытияЗамераКлючевыеСвойства.Ссылка.Владелец КАК Замер,
	|	СобытияЗамераКлючевыеСвойства.Свойство КАК Свойство,
	|	СобытияЗамераКлючевыеСвойства.Значение КАК Значение,
	|	СобытияЗамераКлючевыеСвойства.ХешЗначения КАК Хеш,
	|	СобытияЗамераКлючевыеСвойства.Ссылка.ДатаСобытия КАК Дата,
	|	СобытияЗамераКлючевыеСвойства.Ссылка.ДлительностьМкс КАК ДлительностьМкс,
	|	&Аналитика1 КАК Аналитика1,
	|	НЕОПРЕДЕЛЕНО КАК ЗначениеАналитика1,
	|	&Аналитика2 КАК Аналитика2,
	|	НЕОПРЕДЕЛЕНО КАК ЗначениеАналитика2
	|ИЗ
	|	Справочник.СобытияЗамера.КлючевыеСвойства КАК СобытияЗамераКлючевыеСвойства
	|ГДЕ
	|	СобытияЗамераКлючевыеСвойства.Ссылка.Владелец = &Замер
	|	И СобытияЗамераКлючевыеСвойства.Свойство = &Свойство
	|	И СобытияЗамераКлючевыеСвойства.Ссылка.ДатаСобытия МЕЖДУ &ДатаНачала И &ДатаОкончания
	|
	|УПОРЯДОЧИТЬ ПО
	|	Дата,
	|	СобытияЗамераКлючевыеСвойства.Ссылка";
	Запрос.УстановитьПараметр("Замер",Замер);
	Запрос.УстановитьПараметр("Свойство",Свойство);
	Запрос.УстановитьПараметр("Аналитика1",Аналитика1);
	Запрос.УстановитьПараметр("Аналитика2",Аналитика2);
	Запрос.УстановитьПараметр("ДатаНачала",Период.ДатаНачала);
	Запрос.УстановитьПараметр("ДатаОкончания",Период.ДатаОкончания);
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст,"ВЫБРАТЬ ПЕРВЫЕ 1000","ВЫБРАТЬ ПЕРВЫЕ "+XMLСтрока(Первые));
	
	Если ЗначениеЗаполнено(Аналитика1) Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст,"НЕОПРЕДЕЛЕНО КАК ЗначениеАналитика1,",
			"ЕстьNull(ЗнАн1.Значение,"""") КАК ЗначениеАналитика1,");
		Запрос.Текст = СтрЗаменить(Запрос.Текст,"Справочник.СобытияЗамера.КлючевыеСвойства КАК СобытияЗамераКлючевыеСвойства",
		"Справочник.СобытияЗамера.КлючевыеСвойства КАК СобытияЗамераКлючевыеСвойства
		|ЛЕВОЕ СОЕДИНЕНИЕ Справочник.СобытияЗамера.КлючевыеСвойства КАК ЗнАн1
		|ПО ЗнАн1.Ссылка=СобытияЗамераКлючевыеСвойства.Ссылка
		| И ЗнАн1.Свойство=&Аналитика1"+Символы.ПС);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Аналитика2) Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст,"НЕОПРЕДЕЛЕНО КАК ЗначениеАналитика1,",
			"ЕстьNull(ЗнАн1.Значение,"""") КАК ЗначениеАналитика1,");
		Запрос.Текст = СтрЗаменить(Запрос.Текст,"Справочник.СобытияЗамера.КлючевыеСвойства КАК СобытияЗамераКлючевыеСвойства",
		"Справочник.СобытияЗамера.КлючевыеСвойства КАК СобытияЗамераКлючевыеСвойства
		|ЛЕВОЕ СОЕДИНЕНИЕ Справочник.СобытияЗамера.КлючевыеСвойства КАК ЗнАн2
		|ПО ЗнАн2.Ссылка=СобытияЗамераКлючевыеСвойства.Ссылка
		| И ЗнАн2.Свойство=&Аналитика2"+Символы.ПС);
	КонецЕсли;
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		стр_н = ТаблицаДанных.Добавить();
		ЗаполнитьЗначенияСвойств(стр_н,Выборка);
	КонецЦикла;	
	
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьДанные(Команда)
	ПолучитьДанныеНаСервере();
	Элементы.Страницы.ТекущаяСтраница = Элементы.СтраницаДанные;
КонецПроцедуры


