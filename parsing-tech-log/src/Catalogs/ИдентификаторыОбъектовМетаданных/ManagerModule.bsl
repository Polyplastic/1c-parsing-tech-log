#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Процедура обновляет данные справочника по метаданным конфигурации.
//
// Параметры:
//  ЕстьИзменения - Булево (возвращаемое значение) - в этот параметр возвращается
//                  значение Истина, если производилась запись, иначе не изменяется.
//
//  ЕстьУдаленные - Булево (возвращаемое значение) - в этот параметр возвращается
//                  значение Истина, если хотя бы один элемент справочника был помечен
//                  на удаление, иначе не изменяется.
//
//  ТолькоПроверка - Булево (возвращаемое значение) - не производит никаких изменений,
//                  а лишь выполняет установку флажков ЕстьИзменения, ЕстьУдаленные.
//
Процедура ОбновитьДанныеСправочника(ЕстьИзменения = Ложь, ЕстьУдаленные = Ложь, ТолькоПроверка = Ложь) Экспорт
	
	ВыполнитьОбновлениеДанных(ЕстьИзменения, ЕстьУдаленные, ТолькоПроверка);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Процедура обновляет данные справочника по метаданным конфигурации.
//
// Параметры:
//  ЕстьИзменения - Булево (возвращаемое значение) - в этот параметр возвращается
//                  значение Истина, если производилась запись, иначе не изменяется.
//
//  ЕстьУдаленные - Булево (возвращаемое значение) - в этот параметр возвращается
//                  значение Истина, если хотя бы один элемент справочника был помечен
//                  на удаление, иначе не изменяется.
//
//  ТолькоПроверка - Булево (возвращаемое значение) - не производит никаких изменений,
//                  а лишь выполняет установку флажков ЕстьИзменения, ЕстьУдаленные,
//                  ЕстьКритичныеИзменения.
//
//  ЕстьКритичныеИзменения - (возвращаемое значение) - в этот параметр возвращается
//                  значение Истина, если найдены критичные изменения, иначе не изменяется.
//                    Критичные изменения (только для не помеченных на удаление):
//                    - изменении реквизита ПолноеИмя,
//                    - добавление нового элемента справочника.
//                  В общем случае, критичные изменения требуют монопольный режим.
//
//  СписокКритичныхИзменений - Строка (возвращаемое значение) - содержит полные имена
//                  объектов метаданных, которые добавлены или требуется добавить,
//                  а также объектов метаданных, полные имена которых изменены или требуется изменить.
//
Процедура ВыполнитьОбновлениеДанных(ЕстьИзменения, ЕстьУдаленные, ТолькоПроверка,
	ЕстьКритичныеИзменения = Ложь, СписокКритичныхИзменений = "", ОбъектыРасширений = Ложь) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	
	ЕстьТекущиеИзменения = Ложь;
	СвойстваРасширений = новый Структура;	
	
	ОбновитьДанные(ЕстьТекущиеИзменения, ЕстьУдаленные, ТолькоПроверка,
	ЕстьКритичныеИзменения, СписокКритичныхИзменений, СвойстваРасширений, ОбъектыРасширений);
	
	Если ЕстьТекущиеИзменения Тогда
		ЕстьИзменения = Истина;
	КонецЕсли;
	
	
КонецПроцедуры


#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// См. описание одноименной процедуры в общем модуле ОбщегоНазначения.
Функция ИдентификаторОбъектаМетаданных(ОписаниеОбъектаМетаданных) Экспорт
	
	ТипОписанияОбъектаМетаданных = ТипЗнч(ОписаниеОбъектаМетаданных);
	Если ТипОписанияОбъектаМетаданных = Тип("Тип") Тогда
		
		ОбъектМетаданных = Метаданные.НайтиПоТипу(ОписаниеОбъектаМетаданных);
		Если ОбъектМетаданных = Неопределено Тогда
			ВызватьИсключение СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Ошибка при выполнении функции ОбщегоНазначения.ИдентификаторОбъектаМетаданных().
				           |
				           |Объект метаданных не найден по типу:
				           |""%1"".'"),
				ОписаниеОбъектаМетаданных);
		Иначе
			ПолноеИмяОбъектаМетаданных = ОбъектМетаданных.ПолноеИмя();
		КонецЕсли;
		
	ИначеЕсли ТипОписанияОбъектаМетаданных = Тип("Строка") Тогда
		ПолноеИмяОбъектаМетаданных = ОписаниеОбъектаМетаданных;
	Иначе
		ПолноеИмяОбъектаМетаданных = ОписаниеОбъектаМетаданных.ПолноеИмя();
	КонецЕсли;
	
	Возврат СтандартныеПодсистемыПовтИсп.ИдентификаторОбъектаМетаданныхПоПолномуИмени(ПолноеИмяОбъектаМетаданных);
	
КонецФункции

// Продолжение процедуры ИдентификаторОбъектаМетаданных.
Функция ИдентификаторОбъектаМетаданныхПоПолномуИмени(ПолноеИмяОбъектаМетаданных) Экспорт
	
	
	УстановитьПривилегированныйРежим(Истина);
	
	ДоступныИдентификаторыОбъектовРасширений = Ложь;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ПолноеИмя", ПолноеИмяОбъектаМетаданных);
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Идентификаторы.Ссылка КАК Ссылка,
	|	Идентификаторы.КлючОбъектаМетаданных,
	|	Идентификаторы.ПолноеИмя
	|ИЗ
	|	Справочник.ИдентификаторыОбъектовМетаданных КАК Идентификаторы
	|ГДЕ
	|	Идентификаторы.ПолноеИмя = &ПолноеИмя
	|	И НЕ Идентификаторы.ПометкаУдаления";
	
	
	Выгрузка = Запрос.Выполнить().Выгрузить();
	ЗаголовокОшибки = НСтр("ru = 'Ошибка при выполнении функции ОбщегоНазначения.ИдентификаторОбъектаМетаданных().'");
	
	Если Выгрузка.Количество() = 0 Тогда
		// Если идентификатор не найден по полному имени, возможно что полное имя задано с ошибкой.
		ОбъектМетаданных = Метаданные.НайтиПоПолномуИмени(ПолноеИмяОбъектаМетаданных);
		Если ОбъектМетаданных = Неопределено Тогда
			ОписаниеОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Объект метаданных не найден по полному имени:
				           |""%1"".'"),
				ПолноеИмяОбъектаМетаданных);
			ВызватьИсключение ЗаголовокОшибки + Символы.ПС + Символы.ПС + ОписаниеОшибки;
		КонецЕсли;
		
		Если Не Метаданные.Роли.Содержит(ОбъектМетаданных)
		   И Не Метаданные.ПланыОбмена.Содержит(ОбъектМетаданных)
		   И Не Метаданные.Константы.Содержит(ОбъектМетаданных)
		   И Не Метаданные.Справочники.Содержит(ОбъектМетаданных)
		   И Не Метаданные.Документы.Содержит(ОбъектМетаданных)
		   И Не Метаданные.ЖурналыДокументов.Содержит(ОбъектМетаданных)
		   И Не Метаданные.Отчеты.Содержит(ОбъектМетаданных)
		   И Не Метаданные.Обработки.Содержит(ОбъектМетаданных)
		   И Не Метаданные.ПланыВидовХарактеристик.Содержит(ОбъектМетаданных)
		   И Не Метаданные.ПланыСчетов.Содержит(ОбъектМетаданных)
		   И Не Метаданные.ПланыВидовРасчета.Содержит(ОбъектМетаданных)
		   И Не Метаданные.РегистрыСведений.Содержит(ОбъектМетаданных)
		   И Не Метаданные.РегистрыНакопления.Содержит(ОбъектМетаданных)
		   И Не Метаданные.РегистрыБухгалтерии.Содержит(ОбъектМетаданных)
		   И Не Метаданные.РегистрыРасчета.Содержит(ОбъектМетаданных)
		   И Не Метаданные.БизнесПроцессы.Содержит(ОбъектМетаданных)
		   И Не Метаданные.Задачи.Содержит(ОбъектМетаданных)
		   И Не ЭтоПодсистема(ОбъектМетаданных) Тогда
			
			ОписаниеОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Объект метаданных не поддерживается:
				           |""%1"".
				           |
				           |Допустимы только типы объектов метаданных перечисленные в комментарии к функции.'"),
				ПолноеИмяОбъектаМетаданных);
			ВызватьИсключение ЗаголовокОшибки + Символы.ПС + Символы.ПС + ОписаниеОшибки;
		КонецЕсли;
		
		ШаблонОшибки = ?(ДоступныИдентификаторыОбъектовРасширений,
			НСтр("ru = 'Для объекта метаданных ""%1""
			           |не найден идентификатор в справочнике ""Идентификаторы объектов метаданных"" и
			           |регистре сведений ""Идентификаторы объектов версий расширений"".'"),
			НСтр("ru = 'Для объекта метаданных ""%1""
			           |не найден идентификатор в справочнике ""Идентификаторы объектов метаданных"".'"));
		ВызватьИсключение ЗаголовокОшибки + Символы.ПС + Символы.ПС
			+ СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонОшибки, ПолноеИмяОбъектаМетаданных)
			;
		
	ИначеЕсли Выгрузка.Количество() > 1 Тогда
		ШаблонОшибки = ?(ДоступныИдентификаторыОбъектовРасширений,
			НСтр("ru = 'Для объекта метаданных ""%1""
			           |найдено несколько идентификаторов в справочнике ""Идентификаторы объектов метаданных"" и
			           |регистре сведений ""Идентификаторы объектов версий расширений"".'"),
			НСтр("ru = 'Для объекта метаданных ""%1""
			           |найдено несколько идентификаторов в справочнике ""Идентификаторы объектов метаданных"".'"));
		ВызватьИсключение ЗаголовокОшибки + Символы.ПС + Символы.ПС
			+ СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонОшибки, ПолноеИмяОбъектаМетаданных)	;
	КонецЕсли;
	
	// Проверка соответствия ключа объекта метаданных полному имени объекта метаданных.
	РезультатПроверки = КлючОбъектаМетаданныхСоответствуетПолномуИмени(Выгрузка[0]);
	Если РезультатПроверки.НеСоответствует Тогда
		НазваниеСправочника = НазваниеСправочника(Ложь);
		
		Если РезультатПроверки.ОбъектМетаданных = Неопределено Тогда
			ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Для объекта метаданных ""%1""
				           |найден идентификатор в справочнике ""%2"",
				           |которому соответствует удаленный объект метаданных.'"),
				ПолноеИмяОбъектаМетаданных, НазваниеСправочника);
		Иначе
			ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Для объекта метаданных ""%1""
				           |найден идентификатор в справочнике ""%2"",
				           |который соответствует другому объекту метаданных ""%3"".'"),
				ПолноеИмяОбъектаМетаданных, НазваниеСправочника, РезультатПроверки.ОбъектМетаданных);
		КонецЕсли;
		
		ВызватьИсключение ЗаголовокОшибки + Символы.ПС + Символы.ПС + ТекстОшибки;
	КонецЕсли;
	
	Возврат Выгрузка[0].Ссылка;
	
КонецФункции


Функция ЭтоПодсистема(ОбъектМетаданных, КоллекцияПодсистем = Неопределено)
	
	Если КоллекцияПодсистем = Неопределено Тогда
		КоллекцияПодсистем = Метаданные.Подсистемы;
	КонецЕсли;
	
	Если КоллекцияПодсистем.Содержит(ОбъектМетаданных) Тогда
		Возврат Истина;
	КонецЕсли;
	
	Для Каждого Подсистема Из КоллекцияПодсистем Цикл
		Если ЭтоПодсистема(ОбъектМетаданных, Подсистема.Подсистемы) Тогда
			Возврат Истина;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции

Функция НазваниеСправочника(ОбъектыРасширений)
	
	Если ОбъектыРасширений Тогда
		НазваниеСправочника = НСтр("ru = 'Идентификаторы объектов расширений'");
	Иначе
		НазваниеСправочника = НСтр("ru = 'Идентификаторы объектов метаданных'");
	КонецЕсли;
	
	Возврат НазваниеСправочника;
	
КонецФункции

Функция КлючОбъектаМетаданныхСоответствуетПолномуИмени(СвойстваИдентификатора)
	
	РезультатПроверки = Новый Структура;
	РезультатПроверки.Вставить("НеСоответствует", Истина);
	РезультатПроверки.Вставить("КлючОбъектаМетаданных", Неопределено);
	
	КлючОбъектаМетаданных = СвойстваИдентификатора.КлючОбъектаМетаданных.Получить();
	ОбъектыРасширений = ЭтоОбъектРасширений(СвойстваИдентификатора.Ссылка);
	
	Если КлючОбъектаМетаданных <> Неопределено
	   И КлючОбъектаМетаданных <> Тип("Неопределено") Тогда
		// Ключ задан, поиск объекта метаданных по ключу.
		РезультатПроверки.Вставить("КлючОбъектаМетаданных", КлючОбъектаМетаданных);
		ОбъектМетаданных = ОбъектМетаданныхПоКлючу(КлючОбъектаМетаданных);
		Если ОбъектМетаданных <> Неопределено Тогда
			РезультатПроверки.НеСоответствует = ОбъектМетаданных.ПолноеИмя() <> СвойстваИдентификатора.ПолноеИмя;
		КонецЕсли;
	Иначе
		// Ключ не задан, поиск объекта метаданных по полному имени.
		ОбъектМетаданных = МетаданныеНайтиПоПолномуИмени(СвойстваИдентификатора.ПолноеИмя);
		Если ОбъектМетаданных = Неопределено Тогда
			// Возможно задана коллекция
			
			Строка = СтандартныеПодсистемыПовтИсп.СвойстваКоллекцийОбъектовМетаданных(ОбъектыРасширений).Найти(
				СвойстваИдентификатора.Ссылка.УникальныйИдентификатор(), "Идентификатор");
			
			Если Строка <> Неопределено Тогда
				ОбъектМетаданных = Метаданные[Строка.Имя];
				РезультатПроверки.НеСоответствует = Строка.Имя <> СвойстваИдентификатора.ПолноеИмя;
			КонецЕсли;
		Иначе
			РезультатПроверки.НеСоответствует = Ложь;
		КонецЕсли;
	КонецЕсли;
	
	РезультатПроверки.Вставить("ОбъектМетаданных", ОбъектМетаданных);
	
	Возврат РезультатПроверки;
	
КонецФункции

Функция ЭтоОбъектРасширений(ОбъектИлиСсылка)
	
	Возврат Ложь;
	
КонецФункции

Функция ОбъектМетаданныхПоКлючу(КлючОбъектаМетаданных)
	
	ОбъектМетаданных = Неопределено;
	
	Если ТипЗнч(КлючОбъектаМетаданных) = Тип("Тип") Тогда
		ОбъектМетаданных = Метаданные.НайтиПоТипу(КлючОбъектаМетаданных);
	КонецЕсли;
	
	Возврат ОбъектМетаданных;
	
КонецФункции

Функция МетаданныеНайтиПоПолномуИмени(ПолноеИмя)
	
	ОбъектМетаданных = Метаданные.НайтиПоПолномуИмени(ПолноеИмя);
	
	Если ОбъектМетаданных = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Если ВРег(ОбъектМетаданных.ПолноеИмя()) <> ВРег(ПолноеИмя) Тогда
		
		Если СтрЧислоВхождений(ВРег(ПолноеИмя), ВРег("Подсистема.")) > 1 Тогда
			Подсистема = НайтиПодсистемуПоПолномуИмени(ПолноеИмя);
			Если Подсистема = Неопределено Тогда
				Возврат Неопределено;
			КонецЕсли;
			ВызватьИсключение СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Ошибка при поиске дочерней подсистемы по полному имени (при поиске ""%1"" была найдена ""%2"").
				           |Не следует называть подсистемы одинаково, либо использовать более новую версию платформы.'"),
				ПолноеИмя,
				ОбъектМетаданных.ПолноеИмя());
		Иначе
			ВызватьИсключение СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Ошибка при поиске объекта метаданных по полному имени (при поиске ""%1"" был найден ""%2"").'"),
				ПолноеИмя,
				ОбъектМетаданных.ПолноеИмя());
		КонецЕсли;
	КонецЕсли;
	
	Возврат ОбъектМетаданных;
	
КонецФункции

Функция НайтиПодсистемуПоПолномуИмени(ПолноеИмя, КоллекцияПодсистемы = Неопределено)
	
	Если КоллекцияПодсистемы = Неопределено Тогда
		КоллекцияПодсистемы = Метаданные.Подсистемы;
	КонецЕсли;
	
	ОстатокИмени = Сред(ПолноеИмя, СтрДлина("Подсистема.") + 1);
	Позиция = СтрНайти(ВРег(ОстатокИмени), ВРег("Подсистема."));
	Если Позиция > 0 Тогда
		ИмяПодсистемы = Лев(ОстатокИмени, Позиция - 2);
		ОстатокИмени = Сред(ПолноеИмя, Позиция + СтрДлина("Подсистема."));
	Иначе
		ИмяПодсистемы = ОстатокИмени;
		ОстатокИмени = Неопределено;
	КонецЕсли;
	
	НайденнаяПодсистема = Неопределено;
	Для каждого Подсистема Из КоллекцияПодсистемы Цикл
		Если ВРег(Подсистема.Имя) = ВРег(ИмяПодсистемы) Тогда
			НайденнаяПодсистема = Подсистема;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Если НайденнаяПодсистема = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Если ОстатокИмени = Неопределено Тогда
		Возврат НайденнаяПодсистема;
	КонецЕсли;
	
	Возврат НайтиПодсистемуПоПолномуИмени(ОстатокИмени, НайденнаяПодсистема.Подсистемы);
	
КонецФункции

// Только для внутреннего использования.
Функция СвойстваКоллекцийОбъектовМетаданных(ОбъектыРасширений = Ложь) Экспорт
	
	СвойстваКоллекцийОбъектовМетаданных = Новый ТаблицаЗначений;
	СвойстваКоллекцийОбъектовМетаданных.Колонки.Добавить("Имя",                       Новый ОписаниеТипов("Строка",, Новый КвалификаторыСтроки(50)));
	СвойстваКоллекцийОбъектовМетаданных.Колонки.Добавить("ИмяВЕдЧисле",               Новый ОписаниеТипов("Строка",, Новый КвалификаторыСтроки(50)));
	СвойстваКоллекцийОбъектовМетаданных.Колонки.Добавить("Синоним",                   Новый ОписаниеТипов("Строка",, Новый КвалификаторыСтроки(255)));
	СвойстваКоллекцийОбъектовМетаданных.Колонки.Добавить("СинонимВЕдЧисле",           Новый ОписаниеТипов("Строка",, Новый КвалификаторыСтроки(255)));
	СвойстваКоллекцийОбъектовМетаданных.Колонки.Добавить("ПорядокКоллекции",          Новый ОписаниеТипов("Число"));
	СвойстваКоллекцийОбъектовМетаданных.Колонки.Добавить("БезДанных",                 Новый ОписаниеТипов("Булево"));
	СвойстваКоллекцийОбъектовМетаданных.Колонки.Добавить("БезКлючаОбъектаМетаданных", Новый ОписаниеТипов("Булево"));
	СвойстваКоллекцийОбъектовМетаданных.Колонки.Добавить("Идентификатор",             Новый ОписаниеТипов("УникальныйИдентификатор"));
	СвойстваКоллекцийОбъектовМетаданных.Колонки.Добавить("ОбъектыРасширений",         Новый ОписаниеТипов("Булево"));
	
	// Константы
	Строка = СвойстваКоллекцийОбъектовМетаданных.Добавить();
	Строка.Идентификатор   = Новый УникальныйИдентификатор("627a6fb8-872a-11e3-bb87-005056c00008");
	Строка.Имя             = "Константы";
	Строка.Синоним         = НСтр("ru = 'Константы'");
	Строка.ИмяВЕдЧисле     = "Константа";
	Строка.СинонимВЕдЧисле = НСтр("ru = 'Константа'");
	
	// Подсистемы
	Строка = СвойстваКоллекцийОбъектовМетаданных.Добавить();
	Строка.Идентификатор   = Новый УникальныйИдентификатор("cdf5ac50-08e8-46af-9a80-4e63fd4a88ff");
	Строка.Имя             = "Подсистемы";
	Строка.Синоним         = НСтр("ru = 'Подсистемы'");
	Строка.ИмяВЕдЧисле     = "Подсистема";
	Строка.СинонимВЕдЧисле = НСтр("ru = 'Подсистема'");
	Строка.БезДанных       = Истина;
	Строка.БезКлючаОбъектаМетаданных = Истина;
	Строка.ОбъектыРасширений = Истина;
	
	// Роли
	Строка = СвойстваКоллекцийОбъектовМетаданных.Добавить();
	Строка.Идентификатор   = Новый УникальныйИдентификатор("115c4f55-9c20-4e86-a6d0-d0167ec053a1");
	Строка.Имя             = "Роли";
	Строка.Синоним         = НСтр("ru = 'Роли'");
	Строка.ИмяВЕдЧисле     = "Роль";
	Строка.СинонимВЕдЧисле = НСтр("ru = 'Роль'");
	Строка.БезДанных       = Истина;
	Строка.БезКлючаОбъектаМетаданных = Истина;
	
	// ПланыОбмена
	Строка = СвойстваКоллекцийОбъектовМетаданных.Добавить();
	Строка.Идентификатор   = Новый УникальныйИдентификатор("269651e0-4b06-4f9d-aaab-a8d2b6bc6077");
	Строка.Имя             = "ПланыОбмена";
	Строка.Синоним         = НСтр("ru = 'Планы обмена'");
	Строка.ИмяВЕдЧисле     = "ПланОбмена";
	Строка.СинонимВЕдЧисле = НСтр("ru = 'План обмена'");
	
	// Справочники
	Строка = СвойстваКоллекцийОбъектовМетаданных.Добавить();
	Строка.Идентификатор   = Новый УникальныйИдентификатор("ede89702-30f5-4a2a-8e81-c3a823b7e161");
	Строка.Имя             = "Справочники";
	Строка.Синоним         = НСтр("ru = 'Справочники'");
	Строка.ИмяВЕдЧисле     = "Справочник";
	Строка.СинонимВЕдЧисле = НСтр("ru = 'Справочник'");
	
	// Документы
	Строка = СвойстваКоллекцийОбъектовМетаданных.Добавить();
	Строка.Идентификатор   = Новый УникальныйИдентификатор("96c6ab56-0375-40d5-99a2-b83efa3dac8b");
	Строка.Имя             = "Документы";
	Строка.Синоним         = НСтр("ru = 'Документы'");
	Строка.ИмяВЕдЧисле     = "Документ";
	Строка.СинонимВЕдЧисле = НСтр("ru = 'Документ'");
	
	// ЖурналыДокументов
	Строка = СвойстваКоллекцийОбъектовМетаданных.Добавить();
	Строка.Идентификатор   = Новый УникальныйИдентификатор("07938234-e29b-4cff-961a-9af07a4c6185");
	Строка.Имя             = "ЖурналыДокументов";
	Строка.Синоним         = НСтр("ru = 'Журналы документов'");
	Строка.ИмяВЕдЧисле     = "ЖурналДокументов";
	Строка.СинонимВЕдЧисле = НСтр("ru = 'Журнал документов'");
	Строка.БезДанных       = Истина;
	
	// Отчеты
	Строка = СвойстваКоллекцийОбъектовМетаданных.Добавить();
	Строка.Идентификатор   = Новый УникальныйИдентификатор("706cf832-0ae5-45b5-8a4a-1f251d054f3b");
	Строка.Имя             = "Отчеты";
	Строка.Синоним         = НСтр("ru = 'Отчеты'");
	Строка.ИмяВЕдЧисле     = "Отчет";
	Строка.СинонимВЕдЧисле = НСтр("ru = 'Отчет'");
	Строка.БезДанных       = Истина;
	Строка.ОбъектыРасширений = Истина;
	
	// Обработки
	Строка = СвойстваКоллекцийОбъектовМетаданных.Добавить();
	Строка.Идентификатор   = Новый УникальныйИдентификатор("ae480426-487e-40b2-98ba-d207777449f3");
	Строка.Имя             = "Обработки";
	Строка.Синоним         = НСтр("ru = 'Обработки'");
	Строка.ИмяВЕдЧисле     = "Обработка";
	Строка.СинонимВЕдЧисле = НСтр("ru = 'Обработка'");
	Строка.БезДанных       = Истина;
	Строка.ОбъектыРасширений = Истина;
	
	// ПланыВидовХарактеристик
	Строка = СвойстваКоллекцийОбъектовМетаданных.Добавить();
	Строка.Идентификатор   = Новый УникальныйИдентификатор("8b5649b9-cdd1-4698-9aac-12ba146835c4");
	Строка.Имя             = "ПланыВидовХарактеристик";
	Строка.Синоним         = НСтр("ru = 'Планы видов характеристик'");
	Строка.ИмяВЕдЧисле     = "ПланВидовХарактеристик";
	Строка.СинонимВЕдЧисле = НСтр("ru = 'План видов характеристик'");
	
	// ПланыСчетов
	Строка = СвойстваКоллекцийОбъектовМетаданных.Добавить();
	Строка.Идентификатор   = Новый УникальныйИдентификатор("4295af27-543f-4373-bcfc-c0ace9b7620c");
	Строка.Имя             = "ПланыСчетов";
	Строка.Синоним         = НСтр("ru = 'Планы счетов'");
	Строка.ИмяВЕдЧисле     = "ПланСчетов";
	Строка.СинонимВЕдЧисле = НСтр("ru = 'План счетов'");
	
	// ПланыВидовРасчета
	Строка = СвойстваКоллекцийОбъектовМетаданных.Добавить();
	Строка.Идентификатор   = Новый УникальныйИдентификатор("fca3e7e1-1bf1-49c8-9921-aafb4e787c75");
	Строка.Имя             = "ПланыВидовРасчета";
	Строка.Синоним         = НСтр("ru = 'Планы видов расчета'");
	Строка.ИмяВЕдЧисле     = "ПланВидовРасчета";
	Строка.СинонимВЕдЧисле = НСтр("ru = 'План видов расчета'");
	
	// РегистрыСведений
	Строка = СвойстваКоллекцийОбъектовМетаданных.Добавить();
	Строка.Идентификатор   = Новый УникальныйИдентификатор("d7ecc1e9-c068-44dd-83c2-1323ec52dbbb");
	Строка.Имя             = "РегистрыСведений";
	Строка.Синоним         = НСтр("ru = 'Регистры сведений'");
	Строка.ИмяВЕдЧисле     = "РегистрСведений";
	Строка.СинонимВЕдЧисле = НСтр("ru = 'Регистр сведений'");
	
	// РегистрыНакопления
	Строка = СвойстваКоллекцийОбъектовМетаданных.Добавить();
	Строка.Идентификатор   = Новый УникальныйИдентификатор("74083488-b01e-4441-84a6-c386ce88cdb5");
	Строка.Имя             = "РегистрыНакопления";
	Строка.Синоним         = НСтр("ru = 'Регистры накопления'");
	Строка.ИмяВЕдЧисле     = "РегистрНакопления";
	Строка.СинонимВЕдЧисле = НСтр("ru = 'Регистр накопления'");
	
	// РегистрыБухгалтерии
	Строка = СвойстваКоллекцийОбъектовМетаданных.Добавить();
	Строка.Идентификатор   = Новый УникальныйИдентификатор("9a0d75ff-0eda-454e-b2b7-d2412ffdff18");
	Строка.Имя             = "РегистрыБухгалтерии";
	Строка.Синоним         = НСтр("ru = 'Регистры бухгалтерии'");
	Строка.ИмяВЕдЧисле     = "РегистрБухгалтерии";
	Строка.СинонимВЕдЧисле = НСтр("ru = 'Регистр бухгалтерии'");
	
	// РегистрыРасчета
	Строка = СвойстваКоллекцийОбъектовМетаданных.Добавить();
	Строка.Идентификатор   = Новый УникальныйИдентификатор("f330686a-0acf-4e26-9cda-108f1404687d");
	Строка.Имя             = "РегистрыРасчета";
	Строка.Синоним         = НСтр("ru = 'Регистры расчета'");
	Строка.ИмяВЕдЧисле     = "РегистрРасчета";
	Строка.СинонимВЕдЧисле = НСтр("ru = 'Регистр расчета'");
	
	// БизнесПроцессы
	Строка = СвойстваКоллекцийОбъектовМетаданных.Добавить();
	Строка.Идентификатор   = Новый УникальныйИдентификатор("a8cdd0e0-c27f-4bf0-9718-10ec054dc468");
	Строка.Имя             = "БизнесПроцессы";
	Строка.Синоним         = НСтр("ru = 'Бизнес-процессы'");
	Строка.ИмяВЕдЧисле     = "БизнесПроцесс";
	Строка.СинонимВЕдЧисле = НСтр("ru = 'Бизнес-процесс'");
	
	// Задачи
	Строка = СвойстваКоллекцийОбъектовМетаданных.Добавить();
	Строка.Идентификатор   = Новый УникальныйИдентификатор("8d9153ad-7cea-4e25-9542-a557ee59fd16");
	Строка.Имя             = "Задачи";
	Строка.Синоним         = НСтр("ru = 'Задачи'");
	Строка.ИмяВЕдЧисле     = "Задача";
	Строка.СинонимВЕдЧисле = НСтр("ru = 'Задача'");
	
	Для каждого Строка Из СвойстваКоллекцийОбъектовМетаданных Цикл
		Строка.ПорядокКоллекции = СвойстваКоллекцийОбъектовМетаданных.Индекс(Строка);
	КонецЦикла;
	
	Если ОбъектыРасширений Тогда
		СвойстваКоллекцийОбъектовМетаданных = СвойстваКоллекцийОбъектовМетаданных.Скопировать(
			Новый Структура("ОбъектыРасширений", Истина));
	КонецЕсли;
	
	СвойстваКоллекцийОбъектовМетаданных.Индексы.Добавить("Идентификатор");
	
	Возврат СвойстваКоллекцийОбъектовМетаданных;
	
КонецФункции


// Предотвращает недопустимое изменение идентификаторов объектов метаданных.
// Выполняет обработку дублей подчиненного узла распределенной информационной базы.
//
Процедура ПередЗаписьюОбъекта(Объект) Экспорт
	
	Если Объект.ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

// Только для внутреннего использования.
Процедура ФормаСпискаПриСозданииНаСервере(Форма) Экспорт
	
	Параметры = Форма.Параметры;
	Элементы  = Форма.Элементы;
	
	УпорядочитьИОформитьСписок(Форма);
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

// Только для внутреннего использования.
Процедура ФормаЭлементаПриСозданииНаСервере(Форма) Экспорт 	
	
	Параметры = Форма.Параметры;
	Элементы  = Форма.Элементы;
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Вспомогательные процедуры и функции.

Процедура ОбновитьДанные(ЕстьИзменения, ЕстьУдаленные, ТолькоПроверка,
			ЕстьКритичныеИзменения, СписокКритичныхИзменений, СвойстваРасширений, ОбъектыРасширений)
			
	НачатьТранзакцию();
	Попытка
		
		// Создадим корни метаданных
		ТаблицаКорневыхЭлементов = СвойстваКоллекцийОбъектовМетаданных(Ложь);
		Для каждого стр из ТаблицаКорневыхЭлементов Цикл
			КорневойЭлемент = НайтиОбъектМетаданныхПополномуИмени(стр.Имя);	
			Если ЗначениеЗаполнено(КорневойЭлемент) Тогда
			Иначе
				НовыйЭлементОбъект = Справочники.ИдентификаторыОбъектовМетаданных.СоздатьЭлемент();
				НовыйЭлементОбъект.УстановитьСсылкуНового(Справочники.ИдентификаторыОбъектовМетаданных.ПолучитьСсылку(стр.Идентификатор));
				ОбновитьИОМ(НовыйЭлементОбъект,Неопределено,стр.Имя,стр.Имя,стр.Синоним,стр.БезДанных,Неопределено);
			КонецЕсли;		
			
		КонецЦикла;
		
		// создадим найдем корень Подсистемы
		ИОМ_Родитель = ИдентификаторОбъектаМетаданныхПоПолномуИмени("Подсистемы");
		
		Для каждого Элемент из Метаданные.Подсистемы Цикл
			
			ИОМ_Ссылка = НайтиОбъектМетаданныхПополномуИмени(Элемент.ПолноеИмя());
			
			Если ЗначениеЗаполнено(ИОМ_Ссылка) Тогда
			Иначе
				НовыйЭлементОбъект = Справочники.ИдентификаторыОбъектовМетаданных.СоздатьЭлемент();
				ОбновитьИОМ(НовыйЭлементОбъект,ИОМ_Родитель,Элемент.ПолноеИмя(),Элемент.Имя,Элемент.Синоним,Истина,Неопределено);
			КонецЕсли;		
			
		КонецЦикла;
		
		// создадим найдем корень Роли
		ИОМ_Родитель = ИдентификаторОбъектаМетаданныхПоПолномуИмени("Роли");
		
		Для каждого Элемент из Метаданные.Роли Цикл
			
			ИОМ_Ссылка = НайтиОбъектМетаданныхПополномуИмени(Элемент.ПолноеИмя());
			
			Если ЗначениеЗаполнено(ИОМ_Ссылка) Тогда
			Иначе
				НовыйЭлементОбъект = Справочники.ИдентификаторыОбъектовМетаданных.СоздатьЭлемент();
				ОбновитьИОМ(НовыйЭлементОбъект,ИОМ_Родитель,Элемент.ПолноеИмя(),Элемент.Имя,Элемент.Синоним,Истина,Неопределено);
			КонецЕсли;		
			
		КонецЦикла;
		
		// создадим найдем корень Справочники
		ИОМ_Родитель = ИдентификаторОбъектаМетаданныхПоПолномуИмени("Справочники");
		
		Для каждого Элемент из Метаданные.Справочники Цикл
			
			ИОМ_Ссылка = НайтиОбъектМетаданныхПополномуИмени(Элемент.ПолноеИмя());
			
			Если ЗначениеЗаполнено(ИОМ_Ссылка) Тогда
			Иначе
				НовыйЭлементОбъект = Справочники.ИдентификаторыОбъектовМетаданных.СоздатьЭлемент();
				ОбновитьИОМ(НовыйЭлементОбъект,ИОМ_Родитель,Элемент.ПолноеИмя(),Элемент.Имя,Элемент.Синоним,Ложь,Справочники[Элемент.Имя].ПустаяСсылка());
			КонецЕсли;		
			
		КонецЦикла;
		
		// создадим найдем корень Документы
		ИОМ_Родитель = ИдентификаторОбъектаМетаданныхПоПолномуИмени("Документы");
		
		Для каждого Элемент из Метаданные.Документы Цикл
			
			ИОМ_Ссылка = НайтиОбъектМетаданныхПополномуИмени(Элемент.ПолноеИмя());
			
			Если ЗначениеЗаполнено(ИОМ_Ссылка) Тогда
			Иначе
				НовыйЭлементОбъект = Справочники.ИдентификаторыОбъектовМетаданных.СоздатьЭлемент();
				ОбновитьИОМ(НовыйЭлементОбъект,ИОМ_Родитель,Элемент.ПолноеИмя(),Элемент.Имя,Элемент.Синоним,Ложь,Документы[Элемент.Имя].ПустаяСсылка());
			КонецЕсли;		
			
		КонецЦикла;
		
		// создадим найдем корень Отчеты
		ИОМ_Родитель = ИдентификаторОбъектаМетаданныхПоПолномуИмени("Отчеты");
		
		Для каждого Элемент из Метаданные.Отчеты Цикл
			
			ИОМ_Ссылка = НайтиОбъектМетаданныхПополномуИмени(Элемент.ПолноеИмя());
			
			Если ЗначениеЗаполнено(ИОМ_Ссылка) Тогда
			Иначе
				НовыйЭлементОбъект = Справочники.ИдентификаторыОбъектовМетаданных.СоздатьЭлемент();
				ОбновитьИОМ(НовыйЭлементОбъект,ИОМ_Родитель,Элемент.ПолноеИмя(),Элемент.Имя,Элемент.Синоним,Истина,Неопределено);
			КонецЕсли;		
			
		КонецЦикла;
		
		// создадим найдем корень Обработки
		ИОМ_Родитель = ИдентификаторОбъектаМетаданныхПоПолномуИмени("Обработки");
		
		Для каждого Элемент из Метаданные.Обработки Цикл
			
			ИОМ_Ссылка = НайтиОбъектМетаданныхПополномуИмени(Элемент.ПолноеИмя());
			
			Если ЗначениеЗаполнено(ИОМ_Ссылка) Тогда
			Иначе
				НовыйЭлементОбъект = Справочники.ИдентификаторыОбъектовМетаданных.СоздатьЭлемент();
				ОбновитьИОМ(НовыйЭлементОбъект,ИОМ_Родитель,Элемент.ПолноеИмя(),Элемент.Имя,Элемент.Синоним,Истина,Неопределено);
			КонецЕсли;		
			
		КонецЦикла;		
		
		// создадим найдем корень РегистрыСведений
		ИОМ_Родитель = ИдентификаторОбъектаМетаданныхПоПолномуИмени("РегистрыСведений");
		
		Для каждого Элемент из Метаданные.РегистрыСведений Цикл
			
			ИОМ_Ссылка = НайтиОбъектМетаданныхПополномуИмени(Элемент.ПолноеИмя());
			
			Если ЗначениеЗаполнено(ИОМ_Ссылка) Тогда
			Иначе
				НовыйЭлементОбъект = Справочники.ИдентификаторыОбъектовМетаданных.СоздатьЭлемент();
				ОбновитьИОМ(НовыйЭлементОбъект,ИОМ_Родитель,Элемент.ПолноеИмя(),Элемент.Имя,Элемент.Синоним,Ложь,Неопределено);
			КонецЕсли;		
			
		КонецЦикла;
		
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		ВызватьИсключение;
	КонецПопытки;
	
КонецПроцедуры

Процедура ОбновитьИОМ(НовыйЭлементОбъект,Родитель,ПолноеИмя,Имя,Синоним,БезДанных,ЗначениеПустойСсылки)
	
	ПредставлениеГруппы =" ";
	
	НовыйЭлементОбъект.Наименование = ?(ЗначениеЗаполнено(Синоним),Синоним,ПолноеИмя)+ПредставлениеГруппы;
	НовыйЭлементОбъект.Родитель = Родитель;
	НовыйЭлементОбъект.ПолноеИмя = ПолноеИмя;
	НовыйЭлементОбъект.Имя = Имя;
	НовыйЭлементОбъект.Синоним = Синоним;
	НовыйЭлементОбъект.БезДанных = БезДанных;
	НовыйЭлементОбъект.ЗначениеПустойСсылки = ЗначениеПустойСсылки;
	НовыйЭлементОбъект.КлючОбъектаМетаданных = Новый ХранилищеЗначения(КлючОбъектаМетаданных(НовыйЭлементОбъект.ПолноеИмя));
	Попытка
		НовыйЭлементОбъект.Записать();
	Исключение
		Сообщить(ОписаниеОшибки());
	КонецПопытки;

КонецПроцедуры

Функция НайтиОбъектМетаданныхПополномуИмени(ПолноеИмя)
	
	Запрос = новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	ИдентификаторыОбъектовМетаданных.Ссылка
	|ИЗ
	|	Справочник.ИдентификаторыОбъектовМетаданных КАК ИдентификаторыОбъектовМетаданных
	|ГДЕ
	|	ИдентификаторыОбъектовМетаданных.ПолноеИмя = &ПолноеИмя";
	Запрос.УстановитьПараметр("ПолноеИмя",ПолноеИмя);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Справочники.ИдентификаторыОбъектовМетаданных.ПустаяСсылка();
	КонецЕсли;
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Выборка.Следующий();
	
	Возврат Выборка.Ссылка;	
	
КонецФункции


Функция КлючОбъектаМетаданных(ПолноеИмя)
	
	ПозицияТочки = СтрНайти(ПолноеИмя, ".");
	
	КлассОМ = Лев( ПолноеИмя, ПозицияТочки-1);
	ИмяОМ   = Сред(ПолноеИмя, ПозицияТочки+1);
	
	Если ВРег(КлассОМ) = ВРег("ПланОбмена") Тогда
		Возврат Тип(КлассОМ + "Ссылка." + ИмяОМ);
		
	ИначеЕсли ВРег(КлассОМ) = ВРег("Константа") Тогда
		Возврат ТипЗнч(ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(ПолноеИмя));
		
	ИначеЕсли ВРег(КлассОМ) = ВРег("Справочник") Тогда
		Возврат Тип(КлассОМ + "Ссылка." + ИмяОМ);
		
	ИначеЕсли ВРег(КлассОМ) = ВРег("Документ") Тогда
		Возврат Тип(КлассОМ + "Ссылка." + ИмяОМ);
		
	ИначеЕсли ВРег(КлассОМ) = ВРег("ЖурналДокументов") Тогда
		Возврат ТипЗнч(ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(ПолноеИмя));
		
	ИначеЕсли ВРег(КлассОМ) = ВРег("Отчет") Тогда
		Возврат Тип(КлассОМ + "Объект." + ИмяОМ);
		
	ИначеЕсли ВРег(КлассОМ) = ВРег("Обработка") Тогда
		Возврат Тип(КлассОМ + "Объект." + ИмяОМ);
		
	ИначеЕсли ВРег(КлассОМ) = ВРег("ПланВидовХарактеристик") Тогда
		Возврат Тип(КлассОМ + "Ссылка." + ИмяОМ);
		
	ИначеЕсли ВРег(КлассОМ) = ВРег("ПланСчетов") Тогда
		Возврат Тип(КлассОМ + "Ссылка." + ИмяОМ);
		
	ИначеЕсли ВРег(КлассОМ) = ВРег("ПланВидовРасчета") Тогда
		Возврат Тип(КлассОМ + "Ссылка." + ИмяОМ);
		
	ИначеЕсли ВРег(КлассОМ) = ВРег("РегистрСведений") Тогда
		Возврат Тип(КлассОМ + "КлючЗаписи." + ИмяОМ);
		
	ИначеЕсли ВРег(КлассОМ) = ВРег("РегистрНакопления") Тогда
		Возврат Тип(КлассОМ + "КлючЗаписи." + ИмяОМ);
		
	ИначеЕсли ВРег(КлассОМ) = ВРег("РегистрБухгалтерии") Тогда
		Возврат Тип(КлассОМ + "КлючЗаписи." + ИмяОМ);
		
	ИначеЕсли ВРег(КлассОМ) = ВРег("РегистрРасчета") Тогда
		Возврат Тип(КлассОМ + "КлючЗаписи." + ИмяОМ);
		
	ИначеЕсли ВРег(КлассОМ) = ВРег("БизнесПроцесс") Тогда
		Возврат Тип(КлассОМ + "Ссылка." + ИмяОМ);
		
	ИначеЕсли ВРег(КлассОМ) = ВРег("Задача") Тогда
		Возврат Тип(КлассОМ + "Ссылка." + ИмяОМ);
	Иначе
		// Без ключа объекта метаданных.
		Возврат Тип("Неопределено");
	КонецЕсли;
	
КонецФункции 


// Для процедуры ПриСозданииНаСервереФормыСписка.
Процедура УпорядочитьИОформитьСписок(Форма)
	
	// Порядок.
	Порядок = Форма.Список.КомпоновщикНастроек.Настройки.Порядок;
	Порядок.ИдентификаторПользовательскойНастройки = "ОсновнойПорядок";
	
	Порядок.Элементы.Очистить();
	
	ЭлементПорядка = Порядок.Элементы.Добавить(Тип("ЭлементПорядкаКомпоновкиДанных"));
	ЭлементПорядка.Поле = Новый ПолеКомпоновкиДанных("ПометкаУдаления");
	ЭлементПорядка.ТипУпорядочивания = НаправлениеСортировкиКомпоновкиДанных.Убыв;
	ЭлементПорядка.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
	ЭлементПорядка.Использование = Истина;
	
	ЭлементПорядка = Порядок.Элементы.Добавить(Тип("ЭлементПорядкаКомпоновкиДанных"));
	ЭлементПорядка.Поле = Новый ПолеКомпоновкиДанных("ПорядокКоллекции");
	ЭлементПорядка.ТипУпорядочивания = НаправлениеСортировкиКомпоновкиДанных.Возр;
	ЭлементПорядка.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
	ЭлементПорядка.Использование = Истина;
	
	ЭлементПорядка = Порядок.Элементы.Добавить(Тип("ЭлементПорядкаКомпоновкиДанных"));
	ЭлементПорядка.Поле = Новый ПолеКомпоновкиДанных("Родитель");
	ЭлементПорядка.ТипУпорядочивания = НаправлениеСортировкиКомпоновкиДанных.Возр;
	ЭлементПорядка.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
	ЭлементПорядка.Использование = Истина;
	
	ЭлементПорядка = Порядок.Элементы.Добавить(Тип("ЭлементПорядкаКомпоновкиДанных"));
	ЭлементПорядка.Поле = Новый ПолеКомпоновкиДанных("Синоним");
	ЭлементПорядка.ТипУпорядочивания = НаправлениеСортировкиКомпоновкиДанных.Возр;
	ЭлементПорядка.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
	ЭлементПорядка.Использование = Истина;
	
	// Оформление.
	ЭлементУсловногоОформления = Форма.УсловноеОформление.Элементы.Добавить();
	
	//ЭлементЦветаОформления = ЭлементУсловногоОформления.Оформление.Элементы.Найти("TextColor");
	//ЭлементЦветаОформления.Значение = Метаданные.ЭлементыСтиля.ТекстЗапрещеннойЯчейкиЦвет.Значение;
	//ЭлементЦветаОформления.Использование = Истина;
	
	ЭлементОтбораДанных = ЭлементУсловногоОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементОтбораДанных.ЛевоеЗначение  = Новый ПолеКомпоновкиДанных("Список.ПометкаБудущегоУдаления");
	ЭлементОтбораДанных.ВидСравнения   = ВидСравненияКомпоновкиДанных.Равно;
	ЭлементОтбораДанных.ПравоеЗначение = Истина;
	ЭлементОтбораДанных.Использование  = Истина;
	
	ЭлементОформляемогоПоля = ЭлементУсловногоОформления.Поля.Элементы.Добавить();
	ЭлементОформляемогоПоля.Поле = Новый ПолеКомпоновкиДанных("Синоним");
	ЭлементОформляемогоПоля.Использование = Истина;
	
	ЭлементОформляемогоПоля = ЭлементУсловногоОформления.Поля.Элементы.Добавить();
	ЭлементОформляемогоПоля.Поле = Новый ПолеКомпоновкиДанных("ПолноеИмя");
	ЭлементОформляемогоПоля.Использование = Истина;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли