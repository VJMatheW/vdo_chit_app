import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';

abstract class ContactServiceInterface {
	getContactList();
	createNewContact();
	updateContact();
}

class ContactService implements ContactServiceInterface {
	@override
	createNewContact() {
		// TODO: implement createNewContact
		throw UnimplementedError();
	}

	@override
	Future<List<CustomContact>> getContactList() async {
		Iterable<Contact> cts = await ContactsService.getContacts();
		Set unique = <CustomContact>{};
		RegExp phExp = RegExp(r"^\+\d{12}");
		for (Contact contact in cts) {
			for (Item phone in contact.phones) {
				if (phExp.hasMatch(phone.value)) {
					// print(contact.displayName + "---" + phone.value);
					unique.add(CustomContact(contact.displayName, phone.value));
				}
			}
		}
		return unique.toList();
	}

	@override
	updateContact() {
		// TODO: implement updateContact
		throw UnimplementedError();
	}
}

class CustomContact extends Equatable {
	String _name;
	String _phone;

	CustomContact(this._name, this._phone);

	get getName => _name;
	get getPhone => _phone;

	@override
	List<Object> get props => [this._name, this._phone];
}
