import 'package:flutter/material.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/services/crud/notes_services.dart';

class NewNoteView extends StatefulWidget {
  const NewNoteView({Key? key}) : super(key: key);

  @override
  State<NewNoteView> createState() => _NewNoteViewState();
}

class _NewNoteViewState extends State<NewNoteView> {
  DatabaseNote? _note;
  late final NotesService _notesService;
  late final TextEditingController _textEditingController;


  Future<DatabaseNote> createNewNote() async {
    final existingNote = _note;
    if(existingNote != null){
      return existingNote;
    }
    final currentUser = AuthService.firebase().currentUser!;
    final email = currentUser.email!;
    final owner = await _notesService.getUser(email: email);
    _notesService.createNote(owner: owner);
    return await _notesService.createNote(owner: owner);
  }

  void _deleteNoteIfTextIsEmpty(){
    final note = _note;
    if(_textEditingController.text.isEmpty  && note != null){
      _notesService.deleteNode(id: note.id);
    }
  }

  void _saveNoteIfTextNotEmpty() async {
    final note = _note;
    final text = _textEditingController.text;
    if(note != null && text.isNotEmpty){
      await _notesService.updateNote(note: note, text: text);
    }
  }

  void _textControllerListener() async {
    final note = _note;
    if(note == null){
      return ;
    }
    final text = _textEditingController.text;
    await _notesService.updateNote(note: note, text: text);


  }

  void _setupTextControllerListener(){
    _textEditingController.removeListener(_textControllerListener);
    _textEditingController.addListener(_textControllerListener);
  }

  @override
  void dispose() {
    _deleteNoteIfTextIsEmpty();
    _saveNoteIfTextNotEmpty();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _notesService = NotesService();
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('new Note'),
      ),
      body: FutureBuilder (
        future : createNewNote(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              _note = snapshot.data as DatabaseNote;
              _setupTextControllerListener();
              return TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Start Typing your note...'
                ),
              );
              default :
                return const CircularProgressIndicator();
          }
        },
      )
    );
  }
}
